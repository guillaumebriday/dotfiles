# dotfiles

![](https://github.com/guillaumebriday/dotfiles/workflows/Lint/badge.svg)

This is my dotfiles for my system customizations and to setup my development environment.

![Screenshot](https://raw.githubusercontent.com/guillaumebriday/dotfiles/master/screenshot.png)

## What's included ?

+ Homebrew
  + Installs Homebrew AND brew install's all of my favourite packages
  + Uses homebrew-cask to install all my applications
+ RVM
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
+ VS Code configuration

## How to use it ?

Clone the project in your home directory :

```bash
$ cd ~
$ xcode-select --install
$ git clone https://github.com/guillaumebriday/dotfiles.git
$ cd dotfiles
$ find ~/dotfiles -name '*.sh' | xargs -I file chmod u+x file # Make sure you can execute the scripts
```

**Before running any commands, you must edit files according to your needs.**

For exemple, open the `brew/Brewfile` and remove applications you don't want to install from the list.

At the end of the installation, restart your computer.

## Installation

### Brew

Packages and applications are installed with [https://brew.sh/](https://brew.sh/).

```bash
$ brew/brew.sh
```

### RVM

Ruby is manage with [https://rvm.io](https://rvm.io).

```bash
$ ruby/rvm.sh
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

### ZSH

```bash
$ zsh/zsh.sh
```

Then complete the [n](https://github.com/tj/n#installation) installation for `sudo` privileges.

### iTerm2

Navigate to the preferences window. Towards the bottom of the window you should see an option that says “Load preferences from a custom folder or URL”. Check this option.

Browse to the folder `~/dotfiles/iTerm2`.

### VS Code

```bash
$ vscode/vscode.sh
```
