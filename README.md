# dotfiles

![](https://github.com/guillaumebriday/dotfiles/workflows/Lint/badge.svg)

This is my dotfiles for my system customizations and to setup my development environment.

![Screenshot](https://raw.githubusercontent.com/guillaumebriday/dotfiles/master/screenshot.png)

## What's included ?

+ Homebrew
  + Installs Homebrew AND brew install's all of my favourite packages
  + Uses homebrew-cask to install all my applications
+ mise
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

## How to use it ?

Clone the project in your home directory :

```bash
$ cd ~
$ xcode-select --install
$ git clone https://github.com/guillaumebriday/dotfiles.git && cd dotfiles
$ find ~/dotfiles -name '*.sh' | xargs -I file chmod u+x file # Make sure you can execute the scripts
```

**Before running any commands, you must edit files according to your needs.**

For exemple, open the `brew/Brewfile` and remove applications you don't want to install from the list.

At the end of the installation, restart your computer.

## Installation

### Mise

```bash
$ curl https://mise.run | sh
```

### Brew

Packages and applications are installed with [https://brew.sh/](https://brew.sh/).

```bash
$ brew/brew.sh
```

It will only install important packages.

### ZSH

```bash
$ zsh/zsh.sh
```

### Sensible macOS defaults

```bash
$ macOS/macos.sh
```

### Git

```bash
$ git/git.sh
```

### Vim

```bash
$ vim/vim.sh
```

### SSH

```bash
$ ssh/ssh.sh
```

And create an SSH key:
```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

### Ruby

```bash
$ ruby/ruby.sh
```

### iTerm2

Close iTerm2 before running this command:

```bash
$ iTerm2/iterm.sh
```

### Install all applications

```bash
$ brew bundle --file=brew/Brewfile
```