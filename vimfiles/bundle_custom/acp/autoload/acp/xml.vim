if exists("acp_did_xml") | finish | endif
let acp_did_xml = 1

function acp#xml#MeetsForOmni(context)
	return g:acp_behaviorXmlOmniLength >= 0 &&
				\ a:context =~ '\(<\|<\/\|<[^>]\+ \|<[^>]\+=\"\)\k\{' .
				\              g:acp_behaviorXmlOmniLength . ',}$'
endfunction

function acp#xml#MakeBehavior()
	let behavs = acp#GetDefaults('xml')
	"---------------------------------------------------------------------------
	call add(behavs.xml, {
				\ 'command' : "\<C-x>\<C-o>",
				\ 'meets'   : 'acp#xml#MeetsForOmni',
				\ 'repeat'  : 1,
				\ })
	return behavs
endfunction
