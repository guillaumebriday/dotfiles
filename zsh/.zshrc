export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"
DEFAULT_USER="$USER"

plugins=(git rails bundler laravel5 osx docker)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh

alias zshconfig="vim ~/.zshrc"

# Global aliases
alias cl="clear"
alias sites="cd ~/Sites"
alias weather='curl -s "wttr.in/?lang=fr" | sed -n "1,7p"'
alias cask="brew cask"

# Git aliases
alias gau="git add -u"
alias gd.="git diff --color-words=."
alias gst="clear && git status"
alias gsu="clear && git status -u"
alias nah="git reset --hard HEAD && git clean -fd"
alias undo="git reset HEAD^"
alias wip="git add . && git commit -m WIP"

# Vagrant aliases
alias vd="vagrant destroy"
alias vgs="vagrant global-status"
alias vh="vagrant halt"
alias vp="vagrant provision"
alias vs="vagrant status"
alias vu="vagrant up"

# Docker aliases
alias dc="docker-compose"
alias yt="docker run --rm -u $(id -u):$(id -g) -v $PWD:/data vimagick/youtube-dl"

# Artisan aliases
alias artisan="php artisan"

# Jekyll aliases
alias jbp="JEKYLL_ENV=production jekyll build"
alias js="jekyll serve --draft --config _config.yml,_config.dev.yml"

# Source zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
