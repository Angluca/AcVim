if exists("acp_did_nim") | finish | endif
let acp_did_nim = 1

function acp#nim#MeetsForOmni(context)
	return has('nim') && g:acp_behaviorNimOmniLength >= 0 &&
				\ a:context =~ '\k\.\k\{' .
				\              g:acp_behaviorNimOmniLength . ',}$'
endfunction

function acp#nim#MakeBehavior()
	let behavs = acp#GetDefaults('nim')
	"---------------------------------------------------------------------------
	call add(behavs.nim, {
				\ 'command' : "\<C-x>\<C-o>",
				\ 'meets'   : 'acp#nim#MeetsForOmni',
				\ 'repeat'  : 0,
				\ })
	return behavs
endfunction
