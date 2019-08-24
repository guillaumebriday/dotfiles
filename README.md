# dotfiles

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
+ BetterTouchTool configuration
+ VS Code configuration

## How to use it ?

Clone the project in your home directory :

```bash
$ cd ~
$ git clone git@github.com:guillaumebriday/dotfiles.git
$ cd dotfiles
$ xcode-select --install
$ find ~/dotfiles -name '*.sh' | xargs -I file chmod u+x file # Make sure you can execute the scripts
```

**Before running any commands, you must edit files according to your needs.**

For exemple, open the `brew/Brewfile` and remove applications you don't want to install from the list.

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

When setting up a new Mac, you may want to set some sensible macOS defaults.

```bash
$ macOS/macos.sh
$ sudo cp ~/dotfiles/macOS/nsmb.conf /etc/nsmb.conf
```

### Git

Nothing to install here, link the content of the Git folder into your home :

```bash
$ find ~/dotfiles/git -type f | xargs -I file ln -fs file ~/
```

### GPG

Nothing to install here, link the content of the GPG folder into your home :

```bash
$ ln -fs ~/dotfiles/gpg/gpg-agent.conf ~/.gnupg
```

### Vim

Same here, link the ```vimrc``` file into your home folder.

```bash
$ ln -fs ~/dotfiles/vim/.vimrc ~/
```

### SSH

Configuration file for ssh keys.

```bash
$ cp ssh/config ~/.ssh/config
```

### ZSH

Here too, link the zsh config file to your home folder.

```bash
$ zsh/zsh.sh
```

### iTerm2

```bash
$ iTerm2/iterm.sh
```

Once the theme is downloaded, you can modify your iTerm2 settings in the app.

### BetterTouchTool

It's an export of my BTT configuration. To install, import it into BTT.

### VS Code

Install extensions :
```bash
$ vscode/vscode.sh
```
