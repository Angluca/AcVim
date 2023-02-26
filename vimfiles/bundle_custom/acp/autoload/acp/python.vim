if exists("acp_did_python") | finish | endif
let acp_did_python = 1

function acp#python#MeetsForOmni(context)
	return has('python') && g:acp_behaviorPythonOmniLength >= 0 &&
				\ a:context =~ '\k\.\k\{' .
				\              g:acp_behaviorPythonOmniLength . ',}$'
endfunction

function acp#python#MakeBehavior()
	let behavs = acp#GetDefaults('python')
	"---------------------------------------------------------------------------
	call add(behavs.python, {
				\ 'command' : "\<C-x>\<C-o>",
				\ 'meets'   : 'acp#python#MeetsForOmni',
				\ 'repeat'  : 0,
				\ })
	return behavs
endfunction
