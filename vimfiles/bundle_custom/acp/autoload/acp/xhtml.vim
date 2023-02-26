if exists("acp_did_xhtml") | finish | endif
let acp_did_xhtml = 1

" re-use html setup
function acp#xhtml#MakeBehavior()
	let behavs = acp#GetDefaults('xhtml')
	"---------------------------------------------------------------------------
	call add(behavs.xhtml, {
				\ 'command' : "\<C-x>\<C-o>",
				\ 'meets'   : 'acp#html#MeetsForOmni',
				\ 'repeat'  : 1,
				\ })
	return behavs
endfunction
