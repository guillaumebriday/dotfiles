#!/usr/bin/env bash

# Configuration files
find ~/dotfiles/vscode -name '*.json' | xargs -I file ln -fs file ~/Library/Application\ Support/VSCodium/User/
ln -fs ~/dotfiles/vscode/snippets/ ~/Library/Application\ Support/VSCodium/User

# Packages
code --install-extension alefragnani.project-manager
code --install-extension atipugin.rails-partial
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension bradlc.vscode-tailwindcss
code --install-extension bung87.rails
code --install-extension bung87.vscode-gemfile
code --install-extension bungcip.better-toml
code --install-extension castwide.solargraph
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension code --install-extension CraigMaslowski.erb
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension Gruntfuggly.todo-tree
code --install-extension haaaad.ansible
code --install-extension hollowtree.vue-snippets
code --install-extension HookyQR.beautify
code --install-extension Hridoy.rails-snippets
code --install-extension johnpapa.vscode-peacock
code --install-extension karunamurti.haml
code --install-extension marcostazi.VS-code-vagrantfile
code --install-extension miguel-savignano.ruby-symbols
code --install-extension mikestead.dotenv
code --install-extension mrmlnc.vscode-apache
code --install-extension ms-azuretools.vscode-docker
code --install-extension neilbrayfield.php-docblocker
code --install-extension octref.vetur
code --install-extension onecentlin.laravel-blade
code --install-extension PKief.material-icon-theme
code --install-extension pnp.polacode
code --install-extension possan.nbsp-vscode
code --install-extension rebornix.ruby
code --install-extension redhat.vscode-yaml
code --install-extension ricard.postcss
code --install-extension ritwickdey.LiveServer
code --install-extension robinbentley.sass-indented
code --install-extension shanehofstetter.rails-i18n
code --install-extension shanoor.vscode-nginx
code --install-extension sianglim.slim
code --install-extension steoates.autoimport
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension sysoev.language-stylus
code --install-extension tomoki1207.pdf
code --install-extension Tyriar.sort-lines
code --install-extension usernamehw.indent-one-space
code --install-extension vscoss.vscode-ansible
code --install-extension wayou.vscode-todo-highlight
code --install-extension whatwedo.twig
code --install-extension wmaurer.change-case
code --install-extension yzhang.markdown-all-in-one
code --install-extension zhuangtongfa.Material-theme
code --install-extension Zignd.html-css-class-completion
