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
\pp: edit edit update plugs list  
\aa: edit autocomplete option.  
\uu: edit custom option  

>;yy ;pp or \<alt-c\> \<alt-v\> : system copy paste  
:E \<a-1~9,0\> \<a-h,l,H,L\> gt gT tq: tabnew, switch tab page, H L move tab, tq close  

>;bb : very easy and practice to operate buffer  
 --> j/k/l/f/q: move, s/v: split win, d/D: del/!del, w/W: delout erase buf!!  
 
>;tt : file manage  
;uu ;ut ;uc: see all undo tree and clear all undo  
;xx ...: code comment  
;cb ;cc ;cm ;cu ;cg : manage buffer/file/mru/undo/tags  
;mm ;ma ;n ;* ;/ ;mt: good marks  

>\<space\>h/j/k/l/w/e/b : quickly move  
\<ctrl/shift\>↑/↓/←/→ : move window or resize  
;cl ;cn ;cp ;co ;ci : operation quickfix  
\\= : generate language tags  

>;cal : calendar in vim  
;hm ...: convert 0xff byte  
<f10>: draw!

>ysiwb ysawB ysib" : add symbol for words  
csb" cs\[\( ...: revise symbol  
dsb dsB ds" ... : del symbol  
Sb SB S\[ S" ...: add symbol

**More shortcutkeys:  
You can test them if has similar operation.**  
>mapleader is ,  

>\<f10\> ;we ;bb ;bd ;uu ;ut ;lr ;ld  
;xA ;xa ;x$ ;xu ;xn ;xb ;xl ;xy ;xi ;xs ;xm ;x<Space> ;xx  
;# ;* ;N ;n ;mt ;ma ;mc ;/ ;mm  
;tt ;tl ;tq ;to ;tL ;cc ;ca ;cu ;cg ;cm ;cb ;fl  
;qa ;qq ;qf ;qw ;wf ;ww ;ul ;ve ;P  
;ci ;co ;cp ;cn ;cl ;fg ;fu ;ff ;pp ;yx ;yy ;wsf ;wss  

>,bv ,bs ,bt ,be ,mm ,ma ,mc ,mt  
,hf ,hs ,ht ,hp ,hn ,hg ,hi ,hd ,hm  
sc ,sy ,caL ,cal  

>... and more shortcutkeys.  
hope you like them :)  

## Features
- Happy coding.

