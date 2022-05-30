# dotfiles

My dot files managed by this method: https://news.ycombinator.com/item?id=11070797   
Read more about it here: https://www.atlassian.com/git/tutorials/dotfiles

## Installation
```sh
$ git clone --bare git@github.com:overtune/dotfiles.git $HOME/.dotfiles
$ alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ config checkout
```
