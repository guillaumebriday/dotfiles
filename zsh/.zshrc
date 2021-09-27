export ZSH=~/.oh-my-zsh
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim
export GATSBY_TELEMETRY_DISABLED=1
export ZSH_DISABLE_COMPFIX=true
export DISABLE_SPRING=true
export DISABLE_BETTER_ERRORS=true

ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

plugins=(git rails bundler osx docker yarn)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Openssl config
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# Load rbenv
eval "$(rbenv init -)"

# Add composer to PATH for scripting.
export PATH="$PATH:$HOME/.composer/vendor/bin"

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Source aliases and functions:
for file in ~/dotfiles/zsh/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
