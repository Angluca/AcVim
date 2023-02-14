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
\pp: edit edit update plugins list  
\aa: edit filetype acp option  
\uu: edit custom option  

>;yy ;pp or \<alt-c\> \<alt-v\> : system copy paste  
:E \<a-1~9,0\> \<a-h,l,H,L\> gt gT tq: tabnew, switch tab page, a-HL move tab pos, tq close  

>;bb : very easy and practice to operate buffer  
 --> j/k: move, f/e: open/quicksee win, s/v: split win  
 -> d/D: del/!del buf, w/W: wipe out buf, l: see deleted buf  
 
>;tt : file manage  
;uu ;ut ;uc: open undo tree and clear all undo  
;xx ...: code comment  
;cc ;cC ;ca ;cu ;cg ;cG ;cm ;cb ;ci ;cI ;cr ;cx ;cl ;cd ;cD  
 --> manage buffer/file/mru/undo/tags/dir/change/mixd/rtscript  
;mm ;mc ;mC ;mt ;* ;# ;/ ;? * #: good marks  

>\<space\>h/j/k/l/w/e/b : quickly move  
\<ctrl/shift\>¡ü/¡ý/¡û/¡ú : move resize win  
\\= : generate tags  

>;cal : calendar in vim  
;hm ...: convert 0xff byte  
<f10>: draw!

>ysiwb ysawB ysib" : add symbol for words  
csb" cs\[\( ... : revise symbol  
dsb dsB ds" ... : del symbol  
Sb SB S\[ S" ...: add symbol  
\<c-\\\>cdefgis : cscope map  

**More shortcutkeys:  
You can test them if has similar operation.**  
>mapleader is ,  

>;cc ;cC ;ca ;cu ;cg ;cG ;cm ;cb ;ci ;cI ;cr ;cx ;cl ;cd ;cD  
;xA ;xa ;x$ ;xu ;xn ;xb ;xl ;xy ;xi ;xs ;xm ;x<Space> ;xx  
;we ;bb ;bd ;uu ;ut ;uc ;lr ;ld ;fl  
;qa ;qq ;qf ;qw ;wf ;ww ;ve ;P  
;fg ;fu ;ff ;pp ;yx ;yy ;ds  
;# ;* ;/ ;? ;mt ;ma ;mc ;mm  
;tt ;tl ;tq ;to ;tL  

>,hf ,hs ,ht ,hp ,hn ,hg ,hi ,hd ,hm  
mm ,ma ,mc ,mt ,sc ,sy ,caL ,cal  

>\<f10\>  

>... and more hotkey.  
hope you like them :)  

## Features
- Happy coding.

