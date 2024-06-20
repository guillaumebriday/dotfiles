export ZSH=~/.oh-my-zsh
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim
export GATSBY_TELEMETRY_DISABLED=1
export ZSH_DISABLE_COMPFIX=true
export DISABLE_SPRING=true
export DISABLE_BETTER_ERRORS=true
export DISABLE_RACK_MINI_PROFILER=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export RUBYOPT="-W:deprecated"
# export RUBY_YJIT_ENABLE=true

ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

plugins=(git rails bundler macos docker yarn)

# User configuration
export PATH="/opt/homebrew/sbin:/opt/homebrew/opt/libpq/bin:/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.composer/vendor/bin"

# Load rbenv
eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Source aliases and functions:
for file in ~/dotfiles/zsh/.{aliases,functions,hidden}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
