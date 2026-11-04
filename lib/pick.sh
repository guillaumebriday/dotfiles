#!/usr/bin/env bash
# Sourced by install.sh for -i, not meant to be run on its own.
#
# Plain bash 3.2 on purpose: on a new Mac this runs before Homebrew, so there is
# no newer bash, fzf or gum to lean on yet.

# checklist TITLE LABEL... shows the labels with every box ticked, so enter
# alone keeps everything, and prints the indexes of the ticked ones on stdout.
# It draws on /dev/tty and reads keys from it, because stdin is the piped
# script in the curl flow.
checklist () {
  local title=$1
  shift

  local -a labels=("$@") on=()
  local i n=$# cursor=0 top=0 height key rest

  for (( i = 0; i < n; i++ )); do on[i]=1; done

  # A list longer than the window scrolls, only part of it is drawn
  height=$(( $(stty size </dev/tty | cut -d' ' -f1) - 6 ))
  [ "$height" -ge 3 ] || height=3

  # The alternate screen keeps redraws from piling up in the scrollback, and
  # Ctrl-C must hand the terminal back the way it was found
  printf '\033[?1049h\033[?25l' >/dev/tty
  trap 'printf "\033[?25h\033[?1049l" >/dev/tty; exit 130' INT TERM

  while true; do
    if [ "$cursor" -lt "$top" ]; then
      top=$cursor
    elif [ "$cursor" -ge $(( top + height )) ]; then
      top=$(( cursor - height + 1 ))
    fi

    _checklist_draw

    IFS= read -rsn1 key </dev/tty

    case "$key" in
      $'\033')
        # Arrow keys arrive as ESC [ A, all three bytes at once
        IFS= read -rsn2 rest </dev/tty
        case "$rest" in
          '[A') cursor=$(( (cursor - 1 + n) % n )) ;;
          '[B') cursor=$(( (cursor + 1) % n )) ;;
        esac
        ;;
      k) cursor=$(( (cursor - 1 + n) % n )) ;;
      j) cursor=$(( (cursor + 1) % n )) ;;
      ' ') on[cursor]=$(( 1 - on[cursor] )) ;;
      a)
        # Like yarn: all ticked clears everything, anything else ticks all
        if [ "$(_checklist_count)" -eq "$n" ]; then rest=0; else rest=1; fi
        for (( i = 0; i < n; i++ )); do on[i]=$rest; done
        ;;
      '') break ;;
    esac
  done

  printf '\033[?25h\033[?1049l' >/dev/tty
  trap - INT TERM

  for (( i = 0; i < n; i++ )); do
    [ "${on[i]}" -eq 0 ] || echo "$i"
  done
}

# These read checklist's locals, bash scoping is dynamic
_checklist_count () {
  local i count=0
  for (( i = 0; i < n; i++ )); do count=$(( count + on[i] )); done
  echo "$count"
}

_checklist_draw () {
  local i end mark pointer

  end=$(( top + height ))
  [ "$end" -le "$n" ] || end=$n

  {
    printf '\033[H\033[2J'
    printf '\033[1m%s\033[0m\n' "$title"
    printf '\033[2m↑/↓ or j/k move · space toggle · a all/none · enter confirm\033[0m\n\n'

    for (( i = top; i < end; i++ )); do
      if [ "${on[i]}" -eq 1 ]; then mark=$'\033[32m◉\033[0m'; else mark='◯'; fi
      if [ "$i" -eq "$cursor" ]; then pointer=$'\033[36m❯\033[0m'; else pointer=' '; fi
      printf '%s %s %s\n' "$pointer" "$mark" "${labels[i]}"
    done

    printf '\n\033[2m%d of %d selected' "$(_checklist_count)" "$n"
    [ "$end" -ge "$n" ] || printf ' · more below'
    printf '\033[0m'
  } >/dev/tty
}

# pick_brew_entries FILE TITLE prints FILE without the entries unticked in a
# checklist of its brew, cask and mas lines. Taps stay in, trust_taps and
# brew bundle still need them.
pick_brew_entries () {
  local file=$1 title=$2
  local -a lines=() names=() labels=() at=() skip=()
  local re="^[[:space:]]*(brew|cask|mas)[[:space:]]+['\"]([^'\"]+)['\"]"
  local line i chosen kept=0 dropped=""

  while IFS= read -r line || [ -n "$line" ]; do
    lines+=("$line")

    if [[ $line =~ $re ]]; then
      names+=("${BASH_REMATCH[2]}")
      labels+=("$(printf '\033[2m%-4s\033[0m %s' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}")")
      at+=($(( ${#lines[@]} - 1 )))
    fi
  done <"$file"

  if [ ${#names[@]} -gt 0 ]; then
    # Ctrl-C inside only ends the command substitution, so pass it on
    chosen=$(checklist "$title" "${labels[@]}") || exit 130
    chosen=" $(echo "$chosen" | tr '\n' ' ') "

    for (( i = 0; i < ${#names[@]}; i++ )); do
      case "$chosen" in
        *" $i "*) kept=$(( kept + 1 )) ;;
        *)
          skip[at[i]]=1
          dropped="$dropped ${names[i]}"
          ;;
      esac
    done
  fi

  for (( i = 0; i < ${#lines[@]}; i++ )); do
    [ -n "${skip[i]:-}" ] || printf '%s\n' "${lines[i]}"
  done

  {
    printf '%s: keeping %d of %d\n' "$(basename "$file")" "$kept" "${#names[@]}"
    [ -z "$dropped" ] || printf '  skipping:%s\n' "$dropped"
  } >/dev/tty
}
