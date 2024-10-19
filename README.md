# Stow
Dotfiles managed by [GNU stow](https://www.gnu.org/software/stow/manual/stow.html).

To update the dotfiles, you need to run the following command:

```bash
cd ~/.dotfiles
stow nvim zsh tmux
```

# Initialising a new environment

## Clone the dotfiles repository

```bash
git clonehttps://github.com/olb17/dotfiles.git ~/.dotfiles
```


## Stow

To install [GNU stow](https://www.gnu.org/software/stow/manual/stow.html), run the following command:

```bash
sudo apt install stow
```

## TPM

TPM is the package manager for tmux. It is a plugin manager that allows you to install and manage tmux plugins. To install TPM, you need to clone the repository into the `~/.tmux/plugins/tpm` directory. You can do this by running the following command:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

1. Add new plugin to ~/.tmux.conf with set -g @plugin '...'
1. Press `prefix + I` (prefix is `ctrl + space`) to fetch the plugin.

## Oh-My-Zsh

[Oh-My-Zsh](https://ohmyz.sh) is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout...

To install Oh My Zsh, you need to run the following command:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## NeoVim

[NeoVim](https://neovim.io) is a refactor of Vim. It is designed to improve upon Vim's shortcomings. To install NeoVim, you need to run the following command:

```bash
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```
