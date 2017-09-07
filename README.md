# dotfiles

This is my dotfiles for my system customizations and to setup my development environment.

## What's included ?

+ Homebrew
  + Installs Homebrew AND brew install's all of my favourite packages
  + Uses homebrew-cask to install all my applications
+ macOS
  + Installs applications via the Mac App Store
+ Git
  + Git config
  + Global gitignore
+ Vim config
+ SSH config
+ Oh-My-Zsh
  + Robbyrussell theme
  + Aliases
+ Arthur iTerm2 colors theme
+ BetterTouchTool configuration

## Installation

### Brew

Packages and applications are installed with [https://brew.sh/](https://brew.sh/).

```bash
$ chmod +x brew/brew.sh # Make sure you can execute the file
$ brew/brew.sh
```

### masOS

Before running the ```mas``` command, be sure to install ```brew``` with the last command.

```bash
$ chmod +x ./macOS/mas.sh # Make sure you can execute the file
$ ./macOS/mas.sh
```

### Git

Nothing to install here, just move the content of the Git folder into your home :

```bash
$ cp -r git/. ~/.
```

### Vim

Same here, just move the ``vimrc``` file into your home folder.

```bash
$ cp vim/.vimrc ~/
```

### SSH

Configuration file for ssh keys.

```bash
$ cp ssh/config ~/.ssh/config
```

### ZSH

Here too, just move the zsh config file to your home folder.

```bash
$ cp zsh/.zshrc ~/.zshrc
$ touch ~/.hushlogin # If you want to hide the last login banner on logging
```

### iTerm2

```bash
$ chmod +x iTerm2/iterm.sh # Make sure you can execute the file
$ iTerm2/iterm.sh
```

Once the theme is downloaded, you can modify your iTerm2 settings in the app.

### BetterTouchTool

It's just an export of my BTT configuration. To install, just import it into BTT.
