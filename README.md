# dotfiles

Mes fichiers de configuration pour mon système et mes outils de développement.

## Installation

### Brew

Installation d'outils et de logiciels via le package manager [https://brew.sh/](https://brew.sh/).

```
$ chmod +x brew/brew.sh # Make sure you can execute the file
$ brew/brew.sh
```

### git

Placer les fichiers de configuration générale dans le home :

```
$ cp -r git/. ~/.
```

### Sublime Text

Pour la première installation, j'ai besoin d'installer le ```Package Control``` en suivant cette procédure : [https://packagecontrol.io/installation](https://packagecontrol.io/installation).

Ouvrez le dossier de vos packages depuis le menu ```Preferences > Browse Packages``` et placez le fichier ```Package Control.sublime-settings``` dans le dossier ```Packages/User``` pour installer les packages automatiquement.
Une fois l'installation terminée, fermez Sublime Text et placez le fichier ```Preferences.sublime-settings``` au même endroit avec le fichier ```Default (OSX).sublime-keymap``` si vous êtes sur macOS.

### SSH

Fichier de configuration de base des clés ssh.

```
$ cp ssh/config ~/.ssh/config
```

### ZSH

Fichier ```.zshrc``` pour ma configuration zsh.

```
$ cp spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme
$ cp zsh/.zshrc ~/.zshrc
```

### BetterTouchTool

Export de la configuration de BetterTouchTool. Il suffit de l'importer via l'interface de BTT.
