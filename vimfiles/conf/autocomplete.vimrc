"=================================
" Filetypes autocomplete
"=================================
""""""""""""""
" filetype
""""""""""""""
au BufNewFile,BufRead README*,COPYING setl ft=txt
au BufNewFile,BufRead *.txt setl ft=txt
au BufNewFile,BufRead *.log setl ft=txt
au BufNewFile,BufRead *.asm setl ft=masm
au BufNewFile,BufRead *.inc setl ft=masm
au BufNewFile,BufRead *.asm setl mp=fasm\ %:p

au BufNewFile,BufRead *.mxml setl ft=mxml
au BufNewFile,BufRead *.as setl ft=actionscript
au BufNewFile,BufRead CMakeLists.txt setl ft=cmake
au BufNewFile,BufRead *.p setl ft=pawn
au BufNewFile,BufRead *.md,*.markdown setl ft=markdown
au BufNewFile,BufRead *.shd,*.sc setl ft=glsl

"objc
au BufNewFile,BufRead *.mm setl ft=objc
"squirrel script
au BufNewFile,BufRead *.nut setl ft=squirrel
au BufNewFile,BufRead *.nut setl mp=sq\ %:p
au BufNewFile,BufRead *.nut setl efm=%f:%l:%m

"godot script
au BufNewFile,BufRead *.gd setl ft=gdscript
"weixin
au BufNewFile,BufRead *.wxml setl ft=html
au BufNewFile,BufRead *.wxss setl ft=css

" automaticlly remove trailing whitespace
"au BufWrite *.* call DelTWS() "All kill!!!?
"au BufWrite *.txt call DelTWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :call DelTWS()

au BufWrite *.nim,*.nims,*.zig :call DelTWS()

"for nim language
au FileType nim nmap \= :silent !ctags -R --langdef=nim --langmap=nim:.nim --regex-nim="/^[^\#]*\s+(\w+)\*\s*\{.*\}/\1/t,type/" --regex-nim="/^[^\#]*\s+(\w+)\*.*=/\1/t,type/" --regex-nim="/^[^\#]*proc\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*method\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*auto\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*template\s+(\w+)\*/\1/m,macro/" --regex-nim="/^[^\#]*macro\s+(\w+)\*/\1/m,macro/" --regex-nim="/^[^\#]*\s+`(\w+)[=]?`\*/\1/o,operator/" --regex-nim="/^[^\#]*iterator\s+(\w+)\*/\1/i,iterator/" -f nimtags <cr>{{{}}}

"g/^\(\k\+\t\).*$\n\1.*/d
"$ziglib in tags
let $ZIGLIB = $HOME.'/SDK/zig/bin/lib'
au FileType nim,nims set tags+=$VIMDICT/nimtags,./nimtags
au FileType c,cpp set tags +=$VIMDICT/cpptags
au FileType zig set tags +=$VIMDICT/zigtags
"au FileType zig set directory +=$zigGLIB/

""""""""""""""
" acp base 
""""""""""""""
" -1=nopop
let g:acp_behaviorRubyOmniMethodLength = 2
let g:acp_behaviorRubyOmniSymbolLength = 1
let g:acp_behaviorPerlOmniLength = 2
let g:acp_behaviorPythonOmniLength = 2
let g:acp_behaviorXmlOmniLength = 1
let g:acp_behaviorHtmlOmniLength = 1
let g:acp_behaviorCssOmniPropertyLength = 1
let g:acp_behaviorCssOmniValueLength = 1

let g:acp_behaviorKeywordLength=2
let g:acp_behaviorSnipmateLength = -1
let g:acp_behaviorFileLength = 1
"let g:acp_behaviorUserDefinedFunction = ''
"let g:acp_behaviorUserDefinedMeets = ''
"let g:acp_behaviorKeywordCommand = "\<C-n>"
"let g:acp_behaviorKeywordIgnores = []
"let g:acp_behavior = {}


let g:acp_enableAtStartup = 1
let g:acp_ignorecaseOption = 1
"let g:acp_mappingDriven = 1
"let g:acp_completeoptPreview = 1
let g:acp_completeOption='.,w,b,u,t,k'
"let g:acp_completeOption='.,w,b,u,t,i,k'
"set cpt=".,w,b,u,t,i,k"
".. 当前缓冲区
"w. 其它窗口的缓冲区
"b. 其它载入的缓冲区
"u. 卸载的缓冲区
"t. 标签
"i. 头文件
"k. 文件


""""""""""""""""""""
" acp dict
""""""""""""""""""""
fun! SetFiletypeDict(ft, df, op=0)
	if a:ft == '' || (a:df == '' && a:op == '')
		return
	endif
	let s:cp = a:op == '' ? g:acp_completeOption : a:op
	let s:acpt = a:df == '' ? s:cp : s:cp . a:df
	exe 'au FileType ' . a:ft . " let g:acp_completeOption='".s:acpt."'"
	exe 'au FileType ' . a:ft . " set cpt=".s:acpt.""

	"echow a:op."op:". len(a:op) .'!!!'
	"echow s:cp."cp:". len(s:cp) .'@@@'
	"echow s:cp."acp:". len(s:acpt) .'#####'
	"exe 'au FileType ' .a:ft. ' echow "' .a:ft. ' dict ='.a:df .'"'
endf

if has("win32")
	call SetFiletypeDict('asm', $VIMDICT.'win32.dict')
	call SetFiletypeDict('c,cpp', $VIMDICT.'win32.dict,k'.$VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict', '.,w,b,u,i,k')
else
	"au FileType c,cpp let g:acp_completeOption= $VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict'.',k'.$VIMDICT.'gl.dict'
	call SetFiletypeDict('c,cpp', $VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict'.',k')
endif
call SetFiletypeDict('java', $VIMDICT.'java.dict')
call SetFiletypeDict('js', $VIMDICT.'javascript.dict')
call SetFiletypeDict('vim', $VIMDICT.'vim.dict')
call SetFiletypeDict('perl', $VIMDICT.'perl.dict')
call SetFiletypeDict('php', $VIMDICT.'php.dict,k'.$VIMDICT.'html.dict')
call SetFiletypeDict('html', $VIMDICT.'javascript.dict,k'.$VIMDICT.'html.dict,k'.$VIMDICT.'html5.dict')
call SetFiletypeDict('actionscript', $VIMDICT.'as3.dict')
call SetFiletypeDict('sh', $VIMDICT.'bash.dict')
"au BufNewFile,BufRead *.nut let g:acp_completeOption= $VIMDICT.'squirrel.dict'
call SetFiletypeDict('squirrel', $VIMDICT.'squirrel.dict')
call SetFiletypeDict('lua', $VIMDICT.'lua.dict')
call SetFiletypeDict('nim', $VIMDICT.'nim.dict')
call SetFiletypeDict('zig', $VIMDICT.'zigtags')
"call SetFiletypeDict('zig','','.,w')
"call SetFiletypeDict('zig','.,w,b,u,t,i,k')
"au FileType lua setl tags+=$VIMDICTquick2dx.tags
"au FileType lua setl dict+=$VIMDICTquick2dx.tags

