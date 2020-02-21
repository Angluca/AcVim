"autorun the script
let g:acp_enableAtStartup = 1
let g:acp_behaviorKeywordLength=2
let g:acp_ignorecaseOption = 1
"let g:acp_mappingDriven = 1
"let g:acp_behaviorSnipmateLength = 1
"let g:acp_completeoptPreview = 1
let g:acp_completeOption='.,w,b,u,t,i,k'

if has("win32")
	autocmd FileType asm let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/win32.dict'
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
au BufNewFile,BufRead *.nut let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/squirrel.dict'
au FileType lua let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/lua.dict'
au FileType nim let g:acp_completeOption='.,w,b,u,t,i,k'.$VIMDICT.'/nim.dict'
"au FileType lua setl tags+=$VIMDICT/quick2dx.tags
"au FileType lua setl dict+=$VIMDICT/quick2dx.tags

