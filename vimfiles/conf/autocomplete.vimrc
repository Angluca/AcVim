"=================================
" Filetypes autocomplete
"=================================
""""""""""""""
" filetype
""""""""""""""
com -nargs=+ SetFiletype call s:setFiletype<args>
fun! s:setFiletype(fn, ft, bop=0)
	let l:opt = a:bop == v:false ? ('setl ft='.a:ft) : (a:ft)
	"echow l:opt. ' | '
	exe $"au BufNewFile,BufRead {a:fn} {l:opt}"
endf
SetFiletype('*.vimbp', 'vim')
SetFiletype('README*,COPYING', 'txt')
SetFiletype('*.txt', 'txt')
SetFiletype('*.txt', 'txt')
SetFiletype('*.log', 'txt')
SetFiletype('*.asm', 'masm')
SetFiletype('*.inc', 'masm')
SetFiletype('*.asm', 'setl mp=fasm\ %:p', 1)

SetFiletype('*.mxml', 'mxml')
SetFiletype('*.as', 'actionscript')
SetFiletype('CMakeLists.txt', 'cmake')
SetFiletype('*.p', 'pawn')
SetFiletype('*.md,*.markdown', 'markdown')
SetFiletype('*.shd,*.sc', 'glsl')
SetFiletype('*.mm', 'objc')
"squirrel script
SetFiletype('*.nut', 'squirrel')
SetFiletype('*.nut', 'setl mp=sq\ %:p', 1)
SetFiletype('*.nut', 'setl efm=%f:%l:%m', 1)
"godot script
SetFiletype('*.gd', 'gdscript')
"weixin
SetFiletype('*.wxml', 'html')
SetFiletype('*.wxss', 'css')

" automaticlly remove trailing whitespace
"au BufWrite *.* call DelTWS() "All kill!!!?
"au BufWrite *.txt call DelTWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :DelTWS
au BufWrite *.nim,*.nims,*.zig :DelTWS

"g/^\(\k\+\t\).*$\n\1.*/d
"$ziglib in tags
let $ZIGLIB = $HOME.'/SDK/zigs/zig/lib'
let $NIMLIB = $HOME.'/SDK/nims/nim/lib'
au FileType nim,nims setl tags+=$VIMDICT/nimtags,./nimtags
au FileType c,cpp setl tags +=$VIMDICT/cpptags
au FileType zig setl tags +=$VIMDICT/zigtags
"au FileType zig set directory +=$zigGLIB/

""""""""""""""
" acp base 
""""""""""""""
" -1=nopop
let g:acp_behaviorKeywordLength=2
"let g:acp_behaviorSnipmateLength = 1
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
"let g:acp_completeOption='.,w,b,u,t,d,k'
let g:acp_completeOption='.,w,b,u,t,k'
exe 'set cpt=' . g:acp_completeOption
"let g:acp_completeOption='.,w,b,u,t,i,k'
"set cpt=".,w,b,u,t,d,k"
".. 当前缓冲区
"w. 其它窗口的缓冲区
"b. 其它载入的缓冲区
"u. 卸载的缓冲区
"t. 标签
"i. 头文件
"d. 头文件里定义或宏
"k. 文件


""""""""""""""""""""
" acp dict
""""""""""""""""""""
com -nargs=+ SetAcpDict call s:setCompleteOpt<args>
fun! s:setCompleteOpt(ft, df='', bop=0)
	if a:ft == '' || (a:df == '' && a:bop == v:true)
		return
	endif
	let l:opt = a:bop == 0 ? (g:acp_completeOption.a:df) : a:df
	"echo l:opt . ' |'
	exe 'au FileType ' . a:ft . ' let g:acp_completeOption=' . string(l:opt)
	"exe 'au FileType ' . a:ft . ' set complete=' . l:opt
endf

if has("win32")
	SetAcpDict('asm', $VIMDICT.'win32.dict')
	"SetAcpDict('c,cpp', $VIMDICT.'win32.dict,k'.$VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict', '.,w,b,u,i,k')
	SetAcpDict('c,cpp','.,w,b,u,i,k'.$VIMDICT.'win32.dict,k'.$VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict', 1)
else
	"au FileType c,cpp let g:acp_completeOption= '.w,b,u,k'.$VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict'.',k'.$VIMDICT.'gl.dict'
	SetAcpDict('c,cpp', $VIMDICT.'c.dict,k'.$VIMDICT.'cpp.dict')
endif
SetAcpDict('java', $VIMDICT.'java.dict')
SetAcpDict('js', $VIMDICT.'javascript.dict')
SetAcpDict('vim', $VIMDICT.'vim.dict')
SetAcpDict('perl', $VIMDICT.'perl.dict')
SetAcpDict('php', $VIMDICT.'php.dict,k'.$VIMDICT.'html.dict')
SetAcpDict('html', $VIMDICT.'javascript.dict,k'.$VIMDICT.'html.dict,k'.$VIMDICT.'html5.dict')
SetAcpDict('actionscript', $VIMDICT.'as3.dict')
SetAcpDict('sh', $VIMDICT.'bash.dict')
"au BufNewFile,BufRead *.nut let g:acp_completeOption= $VIMDICT.'squirrel.dict'
SetAcpDict('squirrel', $VIMDICT.'squirrel.dict')
SetAcpDict('lua', $VIMDICT.'lua.dict')
SetAcpDict('nim', $VIMDICT.'nim.dict')
SetAcpDict('zig', $VIMDICT.'zigtags')
"SetAcpDict('zig')
"SetAcpDict('zig','.,w,b,u,t,i,k', 1)
"au FileType lua setl tags+=$VIMDICTquick2dx.tags
"au FileType lua setl dict+=$VIMDICTquick2dx.tags

