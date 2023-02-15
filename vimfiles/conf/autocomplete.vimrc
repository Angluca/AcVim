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
"au BufWrite *.* call DeleteTrailingWS() "All kill!!!?
"au BufWrite *.txt call DeleteTrailingWS()
au BufWrite *.cc,*.cpp,*.cxx,*.hpp,*.[ch] :call DeleteTrailingWS()

au BufWrite *.nim,*.nims,*.zig :call DeleteTrailingWS()

"for nim language
au FileType nim nmap \= :silent !ctags -R --langdef=nim --langmap=nim:.nim --regex-nim="/^[^\#]*\s+(\w+)\*\s*\{.*\}/\1/t,type/" --regex-nim="/^[^\#]*\s+(\w+)\*.*=/\1/t,type/" --regex-nim="/^[^\#]*proc\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*method\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*auto\s+(\w+)\*/\1/f,func/" --regex-nim="/^[^\#]*template\s+(\w+)\*/\1/m,macro/" --regex-nim="/^[^\#]*macro\s+(\w+)\*/\1/m,macro/" --regex-nim="/^[^\#]*\s+`(\w+)[=]?`\*/\1/o,operator/" --regex-nim="/^[^\#]*iterator\s+(\w+)\*/\1/i,iterator/" -f nimtags <cr>{{{}}}

au FileType nim,nims set tags+=./nimtags,./../nimtags


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
let g:acp_completeOption='.,w,b,u,t,i,k'

""""""""""""""""""""
" complete option
""""""""""""""""""""
"fu! s:SetCpOpt(ft, opt)
	"exec 'au FileType ' . a:ft . " let g:acp_completeOption='" . a:opt ."'"
"endf
"call s:SetCpOpt("zig", '.,w,b,u,t,i,k')
"call s:SetCpOpt("vim", '.,w,b,u,t,i,k'.$VIMDICT.'/vim.dict')
if has("win32")
	au FileType asm let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/win32.dict'
	au FileType c,cpp let g:acp_completeOption='.,w,b,u,i,k'.$VIMDICT.'/win32.dict,k'.$VIMDICT.'/c.dict,k'.$VIMDICT.'/cpp.dict'
else
	au FileType c,cpp let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/c.dict,k'.$VIMDICT.'/cpp.dict'.',k'.$VIMDICT.'/gl.dict'
endif
au FileType java let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/java.dict'
au FileType js let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/javascript.dict'
au FileType vim let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/vim.dict'
au FileType perl let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/perl.dict'
au FileType php let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/php.dict,k'.$VIMDICT.'/html.dict'
au FileType html let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/javascript.dict,k'.$VIMDICT.'/html.dict,k'.$VIMDICT.'/html5.dict'
au FileType actionscript let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/as3.dict'
au FileType sh let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/bash.dict'
"au BufNewFile,BufRead *.nut let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/squirrel.dict'
au FileType squirrel let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/squirrel.dict'
au FileType lua let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/lua.dict'
au FileType nim let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/nim.dict'
au FileType zig let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/c.dict,k'.$VIMDICT.'/cpp.dict'
"au FileType zig let g:acp_completeOption='.,w,b,u,t,i,k'
"au FileType lua setl tags+=$VIMDICT/quick2dx.tags
"au FileType lua setl dict+=$VIMDICT/quick2dx.tags

