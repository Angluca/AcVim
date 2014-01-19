pwd |xargs -i ln -s {}/_vimrc $HOME/.vimrc 
pwd |xargs -i ln -s {}/vimfiles $HOME/.vim 
echo "setup finish"
