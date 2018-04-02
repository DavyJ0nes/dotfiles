# dotfiles

## Description

This is a selection of my dot files for vim, zsh etc.

## Installation

### vim

For vim I am using vim8 and its native plugin support. To that end all you will need to do is instantiate the submodules with the following:

```shell
git submodule update --init vim/
```

Then you can symlink the files using the install script: `./install.sh`. If you have a vimrc or vim directory in your HOME directory then these files will be ignored.

### zsh

Am using the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin scripts to help bootstrap my ZSH environment. This has been added as a submodule under `zsh` directory.

To initialise run the following:

```shell
git submodule update --init zsh/
```

As with vim you can symlink the config files by running `./install.sh`. If you already have a .zshrc file or oh-my-zsh installed in your HOME directory then installation will be ignored.

### tmux

To be updated

### iterm2

I have included the panda terminal colour scheme here.

### bin

A selection of helper scripts and functions that are part of everyday use. They include:

- aop: Used on linux laptop to switch audio output between speakers and headphones (is a hack).
- backup: runs backup script (deprecated).
- dnd: enabled Do Not Disturb on OSX
- docker-terraform: wrapper form running terraform in a container.
- dpg: starts a postgres server with Docker.
- gitql: git query language binary.
- ip4: Gets the IP of thunderbolt Ethernet adapter (deprecated).
- json-csv: uses nodes to convert json to csv
- mux: starts new tmux session with desired window configuration (simpler than tmuxinator).
- pingtime: Checks from NIC to Google to test internet connectivity (deprecated).
- start: checklist for starting work for the day (requires pre configuration for dirs).
- stop: checklist for stopping work for the day (requires pre configuration for dirs).
- timeconv: takes argument as seconds and returns formatted version.

# LICENSE

MIT
