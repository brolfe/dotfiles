dotfiles
========

Install oh-my-bash:

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
```

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
