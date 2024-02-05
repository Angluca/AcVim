For programmers
---
**Install Vim** 
> Windows : [Download gvim](http://www.vim.org/download "Vim")  
> linux : sudo apt-get install vim  
> macos : brew install vim

**Setup AcVim**  
>cd AcVim  
#**unix/linux/macos**  
sh setup.sh  
>  
>#**windows**  
setup.bat

**How to use it,  
Let's open the vim.** 
>:PlugUpdate :PlugInstall :PlugUpgrade  
\ee: edit vimrc  
\bb: edit edit update plugins list  
\aa: edit filetype acp option  
\uu: edit custom option  
\vv: edit vim9script custom option  

>;yy ;pp or \<alt-c\> \<alt-v\> : system copy paste  
:E \<a-0~9/H/L/(/)\> gt gT: tabnew, switch tab page and move pos  

>;bb : very easy and practice to operate buffer  
 --> j/k J/K g/G: move, f/e: open/quicksee win, s/v: split win  
 -> d/D: del/!del buf, w/W: wipe out buf, l: see deleted buf  

>;bs ;bv ;bt ;be : another buffer manage  
>;tt : file manage  
;ut ;uc: open undo tree and clear all undo  
;xx ...: code comment  
;cc ;ce ;ca ;cu ;cg ;ct ;cm ;cM ;cb ;ci ;cr ;cx ;cl ;cs ;cd ;cD  
 --> manage buffer/file/mru/undo/tags/dir/change/mixd/rtscript  

>\<space\>r/R:async  
\<alt+shift/shift\>\<up>/\<down>/\<left>/\<right>: move resize win  
\\== : generate tags  
>\<space\>l/L, q: open/close quickfix  

>ysiwb ysawB ysib" : add symbol for words  
csb" cs\[\( ... : revise symbol  
dsb dsB ds" ... : del symbol  
Sb SB S\[ S" ...: add symbol  
\<c-\\\>cdefgis : cscope map  

**More shortcutkeys:  
You can test them if has similar operation.**  
>mapleader is ,  

>;cc ;ce ;ca ;cu ;cg ;ct ;cm ;cM ;cb ;ci ;cr ;cx ;cl ;cs ;cd ;cD  
;xA ;xa ;x$ ;xu ;xn ;xb ;xl ;xy ;xi ;xs ;xm ;x<Space> ;xx  
;wf ;bb ;bd ;ut ;uc ;fl  
;qa ;qq ;qf ;qw ;wf ;ww ;ve ;P  
\\fg \\fu \\ff ;ds ;tt ;tl  

>\<f10\>  

>... and more hotkey.  
hope you like them :)  

## Features
- Happy coding.

