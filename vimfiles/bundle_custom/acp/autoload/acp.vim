vim9script
#=============================================================================
# Copyright (c) 2007-2009 Takeshi NISHIDA
#
#=============================================================================
# LOAD GUARD {{{1

if v:version < 802
	echoerr "Requires vim9."
	finish
endif

# }}}1
#=============================================================================
# Default Behaviors: {{{1

export def GetDefaults(key: string): dict<any>
	var behavs = {[key]: []}
	#---------------------------------------------------------------------------
	add(behavs[key], acp#snipmate#GetBehavior(key))
	#---------------------------------------------------------------------------
	if !empty(g:acp_behaviorUserDefinedFunction) &&
			!empty(g:acp_behaviorUserDefinedMeets)
		add(behavs[key], {
			'command': "\<C-x>\<C-u>",
			'completefunc': g:acp_behaviorUserDefinedFunction,
			'meets': g:acp_behaviorUserDefinedMeets,
			'repeat': 0
		})
	endif
	#---------------------------------------------------------------------------
	add(behavs[key], {
		'command': g:acp_behaviorKeywordCommand,
		'meets': 'MeetsForKeyword',
		'repeat': 0
	})
	#---------------------------------------------------------------------------
	add(behavs[key], {
		'command': "\<C-x>\<C-f>",
		'meets': 'MeetsForFile',
		'repeat': 0
	})
	return behavs
enddef

#
def MeetsForKeyword(context: string = ''): bool
	if g:acp_behaviorKeywordLength < 0 || context == ''
		return false
	endif
	var matches = matchlist(context, '\(\k\{' .. g:acp_behaviorKeywordLength .. ',}\)$')
	if empty(matches)
		return false
	endif
	for ignore in g:acp_behaviorKeywordIgnores
		if stridx(ignore, matches[1]) == 0
			return false
		endif
	endfor
	return true
enddef

#
def MeetsForFile(context: string = ''): bool
	if g:acp_behaviorFileLength < 0 || context == ''
		return false
	endif
	var separator = '\/'
	if has('win32') || has('win64')
		separator = '[/\\]'
	endif
	if context !~ '\f' .. separator .. '\f\{' .. g:acp_behaviorFileLength .. ',}$'
		return false
	endif
	return context !~ '[*/\\][/\\]\f*$\|[^[:print:]]\f*$'
enddef

# }}}1
#=============================================================================
# GLOBAL FUNCTIONS: {{{1

#
export def DefineOption(name: string, val: number)
	if !exists(name)
		execute printf('%s = %d', name, val)
	endif
enddef

#
export def Enable()
	Disable()

	augroup AcpGlobalAutoCommand
		autocmd!
		autocmd InsertEnter * posLast = []| lastUncompletable = {}
		autocmd InsertLeave * FinishPopup(1)
	augroup END

	if g:acp_mappingDriven
		MapForMappingDriven()
	else
		autocmd AcpGlobalAutoCommand CursorMovedI * FeedPopup()
	endif

	nnoremap <silent> i i<C-r>=<SID>FeedPopup()<CR>
	nnoremap <silent> a a<C-r>=<SID>FeedPopup()<CR>
	nnoremap <silent> R R<C-r>=<SID>FeedPopup()<CR>
enddef

#
export def Disable()
	UnmapForMappingDriven()
	augroup AcpGlobalAutoCommand
		autocmd!
	augroup END
	nnoremap i <Nop> | nunmap i
	nnoremap a <Nop> | nunmap a
	nnoremap R <Nop> | nunmap R
enddef

#
export def Lock()
	lockCount += 1
enddef

#
export def Unlock()
	lockCount -= 1
	if lockCount < 0
		lockCount = 0
		throw "AutoComplPop: not locked"
	endif
enddef

#
export def OnPopupPost(): string
	# to clear <C-r>= expression on command-line
	echo ''
	if pumvisible()
		inoremap <silent> <expr> <C-h> OnBs()
		inoremap <silent> <expr> <BS>  OnBs()
		# a command to restore to original text and select the first match
		return (behavsCurrent[iBehavs].command =~ 
			"\<C-p>" ?  "\<C-n>\<Up>" : "\<C-p>\<Down>")
	endif
	iBehavs += 1
	if len(behavsCurrent) > iBehavs
		SetCompletefunc()
		return printf("\<C-e>%s\<C-r>=acp#OnPopupPost()\<CR>",
			behavsCurrent[iBehavs].command)
	else
		lastUncompletable = {
			'word': GetCurrentWord(),
			'commands': map(copy(behavsCurrent), 'v:val.command')[1 :]
		}
		echo lastUncompletable
		FinishPopup(0)
		return "\<C-e>"
	endif
enddef

#
def OnBs(): string
	# using "matchstr" and not "strpart" in order to handle multi-byte
	# characters
	if call(behavsCurrent[iBehavs].meets, [matchstr(GetCurrentText(), '.*\ze.')])
		return "\<BS>"
	endif
	return "\<C-e>\<BS>"
enddef

# }}}1
#=============================================================================
# LOCAL FUNCTIONS: {{{1

#
const keysMappingDriven_ = [
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'-', '_', '~', '^', '.', ',', ':', '!', '#', '=',
	'%', '$', '@', '<', '>', '/', '\', '<Space>', '<C-h>', '<BS>', ]
var keysMappingDriven = []
def MapForMappingDriven()
	UnmapForMappingDriven()
	keysMappingDriven = keysMappingDriven_
	for key in keysMappingDriven
		execute printf('inoremap <silent> %s %s<C-r>=<SID>FeedPopup()<CR>',
		key, key)
	endfor
enddef

#
def UnmapForMappingDriven()
	if !exists('keysMappingDriven') || keysMappingDriven == []
		return
	endif
	for key in keysMappingDriven
		execute 'iunmap ' .. key
	endfor
	keysMappingDriven = []
enddef

#
def SetTempOption(group: number, name: string, value: any = 0)
	extend(tempOptionSet[group], {[name]: eval('&' .. name)}, 'keep')
	var v = value->type()
	if v == v:t_string
		execute printf(':set %s=%s', name, value)
	elseif v == v:t_bool
		if value == true
			execute printf(':set %s', name)
		else
			execute printf(':set no%s', name)
		endif
	else
		execute printf(':set %s=%d', name, value)
	endif
enddef

#
def RestoreTempOptions(group: number)
	#echo tempOptionSet
	for [name, value] in items(tempOptionSet[group])
		#echo $"{name} .. {value}"
		var v = value->type()
		if v == v:t_string
			execute printf(':set %s=%s', name, value)
		elseif v == v:t_bool
			if value == true
				execute printf(':set %s', name)
			else
				execute printf(':set no%s', name)
			endif
		else
			execute printf(':set %s=%d', name, value)
		endif
	endfor
	tempOptionSet[group] = {}
enddef

#
def GetCurrentWord(): string
	return matchstr(GetCurrentText(), '\k*$')
enddef

#
def GetCurrentText(): string
	return strpart(getline('.'), 0, col('.') - 1)
enddef

#
def GetPostText(): string
	return strpart(getline('.'), col('.') - 1)
enddef

#
def IsModifiedSinceLastCall(): bool
	var posPrev = []
	var nLinesPrev = 0
	var textPrev = ''
	if exists('posLast')
		posPrev = posLast
		nLinesPrev = nLinesLast
		textPrev = textLast
	endif
	posLast = getpos('.')
	nLinesLast = line('$')
	textLast = getline('.')
	if !exists('posPrev')
		return true
	elseif posPrev[1] != posLast[1] || nLinesPrev != nLinesLast
		return (posPrev[1] - posLast[1] == nLinesPrev - nLinesLast)
	elseif textPrev ==# textLast
		return false
	elseif posPrev[2] > posLast[2]
		return true
	elseif has('gui_running') && has('multi_byte')
		# NOTE: auto-popup causes a strange behavior when IME/XIM is working
		return posPrev[2] + 1 == posLast[2]
	endif
	return posPrev[2] != posLast[2]
enddef

#
def MakeCurrentBehaviorSet(): list<dict<any>>
	var behavs: list<dict<any>>
	var modified = IsModifiedSinceLastCall()
	if exists('behavsCurrent[iBehavs].repeat') && behavsCurrent[iBehavs].repeat
		behavs = [behavsCurrent[iBehavs]]
	elseif exists('behavsCurrent[iBehavs]')
		return []
	elseif modified
		#echo g:acp_behavior
		behavs = copy(exists('g:acp_behavior[&filetype]')
			? g:acp_behavior[&filetype]
			: g:acp_behavior['*'])
	else
		return []
	endif
	var text = GetCurrentText()
	filter(behavs, 'call(v:val.meets, [' .. string(text) .. '])')
	iBehavs = 0
	if lastUncompletable != {} &&
			stridx(GetCurrentWord(), lastUncompletable.word) == 0 &&
			map(copy(behavs), 'v:val.command') == lastUncompletable.commands
		behavs = []
	else
		lastUncompletable = {}
	endif
	return behavs
enddef

#
def FeedPopup(): string
	# NOTE: CursorMovedI is not triggered while the popup menu is visible. And
	#       it will be triggered when popup menu is disappeared.
	if lockCount > 0 || pumvisible() || &paste
		return ''
	endif
	if exists('behavsCurrent[iBehavs].OnPopupClose')
		if !call(behavsCurrent[iBehavs].OnPopupClose, [])
			FinishPopup(1)
			return ''
		endif
	endif
	behavsCurrent = MakeCurrentBehaviorSet()
	if empty(behavsCurrent)
		FinishPopup(1)
		return ''
	endif
	# In case of dividing words by symbols (e.g. "for(int", "ab==cd") while a
	# popup menu is visible, another popup is not available unless input <C-e>
	# or try popup once. So first completion is duplicated.
	insert(behavsCurrent, behavsCurrent[iBehavs])
	SetTempOption(GROUP0, 'spell', false)
	SetTempOption(GROUP0, 'completeopt', 'menuone' .. (g:acp_completeoptPreview ? ',preview' : ''))
	SetTempOption(GROUP0, 'complete', g:acp_completeOption)
	SetTempOption(GROUP0, 'ignorecase', g:acp_ignorecaseOption ? true : false)
	# NOTE: With CursorMovedI driven, Set 'lazyredraw' to avoid flickering.
	#       With Mapping driven, set 'nolazyredraw' to make a popup menu visible.
	SetTempOption(GROUP0, 'lazyredraw', !g:acp_mappingDriven)
	# NOTE: 'textwidth' must be restored after <C-e>.
	SetTempOption(GROUP1, 'textwidth', 0)
	SetCompletefunc()
	feedkeys(behavsCurrent[iBehavs].command .. "\<C-r>=acp#OnPopupPost()\<CR>", 'n')
	return '' # this function is called by <C-r>=
enddef

#
def FinishPopup(fGroup1: bool)
	inoremap <C-h> <Nop> | iunmap <C-h>
	inoremap <BS>  <Nop> | iunmap <BS>
	behavsCurrent = []
	RestoreTempOptions(GROUP0)
	if fGroup1
		RestoreTempOptions(GROUP1)
	endif
enddef

#
def SetCompletefunc()
	if exists('behavsCurrent[iBehavs].Completefunc')
		call SetTempOption(0, 'completefunc', behavsCurrent[iBehavs].Completefunc)
	endif
enddef

# }}}1
#=============================================================================
# INITIALIZATION {{{1

var GROUP0 = 0
var GROUP1 = 1
var iBehavs = 0
var lockCount = 0
var tempOptionSet = [{}, {}]
var posLast = []
var nLinesLast = 0
var textLast = ''
var behavsCurrent: list<dict<any>>
var lastUncompletable: dict<any>

# }}}1
#=============================================================================
# vim: set fdm=marker:
#test_override('autoload', 1)
#:defcompile
