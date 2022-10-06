
# Set up editor
export EDITOR=vim

# Hate dupes on scrollback:
export HISTCONTROL=ignoredups

alias tmux='tmux attach || tmux'

# git stuff
alias gk='git status'

# Enable vi mode for command line.
set -o vi

alias blaze='bazel'
alias hg='git'
# alias gitrefresh='currBranch=$(git rev-parse --abbrev-ref HEAD) && git co master && git pull && git co $currBranch && git rebase master'
alias gitrefresh='git co master && git pull && git co - && git rebase master'
