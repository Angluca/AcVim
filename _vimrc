vim9script
if has("win32")
$VIM = $HOME .. '/vimfiles/'
else
$VIM = $HOME .. '/.vim/'
endif
$VIMDATA = $HOME .. '/.vimdata/'
$VIMDICT = $VIM .. 'dict/'
$VIMCONF = $VIM .. 'conf/'
so $VIMCONF/ac.vimrc
