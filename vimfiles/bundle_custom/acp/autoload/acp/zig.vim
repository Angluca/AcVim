if exists("acp_did_zig") | finish | endif
let acp_did_zig = 1

function acp#zig#MeetsForOmni(context)
	return has('zig') && g:acp_behaviorZigOmniLength >= 0 &&
				\ a:context =~ '\k\.\k\{' .
				\              g:acp_behaviorZigOmniLength . ',}$'
endfunction

function acp#zig#MakeBehavior()
	let behavs = acp#GetDefaults('zig')
	"---------------------------------------------------------------------------
	call add(behavs.zig, {
				\ 'command' : "\<C-x>\<C-o>",
				\ 'meets'   : 'acp#zig#MeetsForOmni',
				\ 'repeat'  : 0,
				\ })
	return behavs
endfunction
