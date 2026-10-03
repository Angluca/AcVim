vim9script
if has("win32")
$VIM = $HOME .. '/vimfiles/'
else
$VIM = $HOME .. '/.vim/'
endif
$VIMDATA = $HOME .. '/.vimdata/'
$VIMDICT = $VIM .. 'dict/'
$VIMCONF = $VIM .. 'conf/'
$VIMPLUGS = $VIM .. 'bundle/'
$VIMPLUGSLOCAL = $VIM .. 'bundle_local/'
so $VIMCONF/ac.vimrc
