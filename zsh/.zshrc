export ZSH=~/.oh-my-zsh
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim

ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

plugins=(git rails bundler osx docker)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Add composer to PATH for scripting.
export PATH="$PATH:$HOME/.composer/vendor/bin"

source $ZSH/oh-my-zsh.sh

# Global aliases
alias zshconfig="vim ~/.zshrc"
alias cl="clear"
alias sites="cd ~/Sites"
alias weather='curl -s "wttr.in/lyon?lang=fr"'
alias cask="brew cask"
alias cat="ccat"
alias mkdir="mkdir -p"
alias f="open ."
alias man="tldr"
alias hostfile="sudo vim /etc/hosts"
alias code="codium"
alias yui="yarn upgrade-interactive --latest"
alias please='sudo $(fc -ln -1)'

# Flush Directory Service cache
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Git aliases
alias gau="git add -u"
alias gd.="git diff --color-words=."
alias gst="clear && git status"
alias gs="gst"
alias gsu="clear && git status -u"
alias nah="git reset --hard HEAD && git clean -fd"
alias undo="git reset HEAD\^"
alias wip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias go="git open"
alias tigd="tig master..HEAD --first-parent --no-merges"
alias gdc="git diff --cached"

# Vagrant aliases
alias vd="vagrant destroy"
alias vgs="vagrant global-status"
alias vh="vagrant halt"
alias vp="vagrant provision"
alias vs="vagrant status"
alias vu="vagrant up"

# Docker aliases
alias dps="docker ps"
alias dc="docker-compose"
alias dcup="docker-compose up -d"
alias dcups="docker-compose up -d && bundle exec rails s"
alias dcd="docker-compose down"
alias yt="docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl"
dbash() { docker exec -it "$1" /bin/bash; }

# Ruby aliases
alias c="bundle exec rails c"
alias s="bundle exec rails s"
alias boe="bundle outdated --only-explicit"
alias mrubocop="git diff --name-only | xargs rubocop"

# PHP aliases
alias phpunit="vendor/bin/phpunit"
alias phpcs="vendor/bin/php-cs-fixer"
alias artisan="php artisan"
alias mfs="php artisan migrate:fresh --seed"

# Source zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
