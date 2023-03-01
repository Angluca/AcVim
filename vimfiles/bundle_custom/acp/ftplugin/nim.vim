if exists("did_acp_ft_nim") | finish | endif
let did_acp_ft_nim = 1

call acp#DefineOption('g:acp_behaviorNimLength', 1)
call extend(g:acp_behavior, acp#nim#MakeBehavior(), 'keep')

