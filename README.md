# dotfiles

These are my dotfiles for my system customizations and to setup my development environment.

## What's included?

+ Homebrew
  + Installs Homebrew AND brew installs all of my favourite packages
  + Uses homebrew-cask to install all my applications
+ mise
+ macOS
  + Installs applications via the Mac App Store
+ Git
  + Git config
  + Global gitignore
+ Vim config
+ SSH config
+ Hosts
  + Blocks ads and trackers with the StevenBlack list, straight in `/etc/hosts`
+ Oh-My-Zsh
  + Robbyrussell theme
  + Aliases
+ Arthur iTerm2 colors theme

## How to use it?

On a brand new machine, run the installer straight from GitHub:

```bash
$ curl -fsSL https://raw.githubusercontent.com/guillaumebriday/dotfiles/master/install.sh | bash
```

It asks which steps you want, installs the Command Line Tools if they are
missing, clones this repo into `~/dotfiles` and installs from there.

The scripts assume the repo lives in `~/dotfiles`, so clone it there when you do
it by hand:

```bash
$ cd ~
$ xcode-select --install
$ git clone https://github.com/guillaumebriday/dotfiles.git && cd dotfiles
```

**Before running any commands, you must edit files according to your needs.**

For example, open the `brew/Brewfile` and remove applications you don't want to install from the list.

At the end of the installation, restart your computer.

## Installation

Run everything, in the right order:

```bash
$ ./install.sh
```

Every step is idempotent, so re-running it is safe, and only one install runs at
a time. To replay a single step, pass its name (`./install.sh --help` lists them
all):

```bash
$ ./install.sh git vim
```

Naming steps skips the questions. Piped from curl, they go after `-s --`:

```bash
$ curl -fsSL https://raw.githubusercontent.com/guillaumebriday/dotfiles/master/install.sh | bash -s -- git vim
```

`-i` asks which steps to run, which is what the curl one-liner does for you:

```bash
$ ./install.sh -i
```

If a step fails, the run stops there and says so, so you can fix it and resume
from that step.

The steps are also runnable on their own, as described below.

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

### Hosts

Symlinks `update-hosts` into `~/.local/bin`:

```bash
$ hosts/hosts.sh
```

It rewrites everything below the marker line in `/etc/hosts` with the [StevenBlack list](https://github.com/StevenBlack/hosts), so your own entries stay on top. Run it whenever you want a fresh list:

```bash
$ sudo update-hosts
```

To try it without touching the real file, point it somewhere else:

```bash
$ head -11 /etc/hosts > ~/hosts-preview
$ HOSTS_FILE=~/hosts-preview update-hosts
```

Domains you want to keep working go in the `ALLOWED` list at the top of the script.

### iTerm2

Close iTerm2 before running this command:

```bash
$ iTerm2/iterm.sh
```

### Install all applications

```bash
$ brew bundle --file=brew/Brewfile
```
