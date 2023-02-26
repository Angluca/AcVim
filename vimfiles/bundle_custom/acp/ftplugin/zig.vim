if exists("did_acp_ft_zig") | finish | endif
let did_acp_ft_zig = 1

call acp#DefineOption('g:acp_behaviorZigLength', 1)
call extend(g:acp_behavior, acp#zig#MakeBehavior(), 'keep')

