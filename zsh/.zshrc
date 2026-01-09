export ZSH=~/.oh-my-zsh
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim
export GATSBY_TELEMETRY_DISABLED=1
export ZSH_DISABLE_COMPFIX=true
export DISABLE_BETTER_ERRORS=true
export DISABLE_RACK_MINI_PROFILER=true
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export RUBYOPT="-W:deprecated"

ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

plugins=(git rails bundler macos docker docker-compose yarn)

# User configuration
export PATH="/opt/homebrew/sbin:/opt/homebrew/opt/libpq/bin:/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.composer/vendor/bin"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="./vendor/bin:$PATH"

# Load mise
eval "$(~/.local/bin/mise activate zsh)"

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh-syntax-highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Source aliases and functions:
for file in ~/dotfiles/zsh/.{aliases,functions,hidden}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
