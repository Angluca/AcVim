Angluca's vimrc

---

## Todo
>
## cd AcVim
### unix
> pwd |xargs -i ln -s {}/_vimrc $HOME/.vimrc

> pwd |xargs -i ln -s {}/vimfiles $HOME/.vim

or

> sh setup.sh
### win
> mklink /H \_vimrc ~/.vimrc

> mklink /H vimfiles ~/.vim
### How to use
open vim and :PlugUpdate :PlugInstall :PlugUpgrade

\ee: edit vimrc

\pp: edit edit update plugs list

\aa: edit autocomplete option.

\uu: edit custom option

## Features
- Happy coding.
