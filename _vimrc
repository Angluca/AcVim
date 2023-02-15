if has("win32")
let $VIM=$HOME.'/vimfiles/'
else
let $VIM=$HOME.'/.vim/'
endif

let $VIMDICT=$VIM.'/dict/'
let $VIMCONF=$VIM.'/conf/'
let $VIMDATA=$HOME.'/vimdata/'
source $VIMCONF/Ac.vimrc
