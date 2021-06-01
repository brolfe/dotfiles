dotfiles
========

Install oh-my-zsh:

```shell
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Add `vi-mode` list of plugins in `.zshrc`.

Clone this repo:

```shell
cd ~
git clone https://github.com/brolfe/dotfiles.git
```

Execute `setup.sh`

```shell
cd ~/dotfiles
./setup.sh
```

To add plugins, follow:

https://github.com/gmarik/Vundle.vim

(Execute `:PluginInstall` within Vim.)

For tmux, start `tmux` then run `prefix + I` to install tmux plugins.
That is, Ctrl + a then capital "I".
