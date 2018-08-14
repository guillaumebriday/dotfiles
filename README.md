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

## Installation

### Brew

Packages and applications are installed with [https://brew.sh/](https://brew.sh/).

```bash
$ chmod u+x brew/brew.sh # Make sure you can execute the file
$ brew/brew.sh
```

### RVM

Ruby is manage with [https://rvm.io](https://rvm.io).

```bash
$ chmod u+x ruby/rvm.sh # Make sure you can execute the file
$ ruby/rvm.sh
$ ln -fs ~/dotfiles/ruby/.gemrc ~/
$ ln -fs ~/dotfiles/ruby/.irbrc ~/
```

### PHP with composer

```bash
$ chmod u+x php/composer.sh # Make sure you can execute the file
$ php/composer.sh
```

#### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults.

```bash
$ xcode-select --install
$ chmod u+x ./macOS/.macos # Make sure you can execute the file
$ ./macOS/.macos
```

### Git

Nothing to install here, link the content of the Git folder into your home :

```bash
$ find ~/dotfiles/git -type f | xargs -I file ln -fs file ~/
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
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # install oh-my-zsh
$ ln -fs ~/dotfiles/zsh/.zshrc ~/
$ touch ~/.hushlogin # If you want to hide the last login banner on logging
```

### iTerm2

```bash
$ chmod u+x iTerm2/iterm.sh # Make sure you can execute the file
$ iTerm2/iterm.sh
```

Once the theme is downloaded, you can modify your iTerm2 settings in the app.

### BetterTouchTool

It's an export of my BTT configuration. To install, import it into BTT.

### VS Code

Install extensions :
```bash
$ chmod u+x ./vscode/package.sh # Make sure you can execute the file
$ ./vscode/package.sh
```

To link my configuration :
```bash
$ find ~/dotfiles/vscode -name '*.json' | xargs -0 -I file ln -fs file ~/Library/Application\ Support/Code/User/
```
