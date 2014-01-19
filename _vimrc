if has("win32")
let $VIM=$HOME.'/vimfiles'
else
let $VIM=$HOME.'/.vim'
endif

let $VIMDICT=$VIM.'/dict'
let $VIMCONF=$VIM.'/conf'
source $VIMCONF/Ac.vimrc
