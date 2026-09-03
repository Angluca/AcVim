vim9script
# 检查 +signs 支持
if !has('signs')
    echohl ErrorMsg
    echo 'ShowMarks requires Vim to have +signs support.'
    echohl None
    finish
endif

# ---- 默认选项 ----
if !exists('g:showmarks_enable')
    g:showmarks_enable = 1
endif
if !exists('g:showmarks_textlower')
    g:showmarks_textlower = '>'
endif
if !exists('g:showmarks_textupper')
    g:showmarks_textupper = '>'
endif
if !exists('g:showmarks_textother')
    g:showmarks_textother = '>'
endif
if !exists('g:showmarks_ignore_type')
    g:showmarks_ignore_type = 'hq'
endif
if !exists('g:showmarks_ignore_name')
    g:showmarks_ignore_name = ''
endif
if !exists('g:showmarks_hlline_lower')
    g:showmarks_hlline_lower = 0
endif
if !exists('g:showmarks_hlline_upper')
    g:showmarks_hlline_upper = 0
endif
if !exists('g:showmarks_hlline_other')
    g:showmarks_hlline_other = 0
endif

const ALL_MARKS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""

# ---- 命令 ----
command! -nargs=0 ShowMarksToggle   call g:ShowMarksToggle()
command! -nargs=0 ShowMarksOn       call g:ShowMarksOn()
command! -nargs=0 ShowMarksClearMark call g:ShowMarksClearMark()
command! -nargs=0 ShowMarksClearAll  call g:ShowMarksClearAll()
command! -nargs=0 ShowMarksPlaceMark call g:ShowMarksPlaceMark()

# ---- 映射 ----
if !hasmapto('<Plug>ShowMarksToggle')
    nmap <silent> <unique> <leader>mt :ShowMarksToggle<CR>
endif
if !hasmapto('<Plug>ShowmarksClearMark')
    nmap <silent> <unique> <leader>md :ShowMarksClearMark<CR>
endif
if !hasmapto('<Plug>ShowmarksClearAll')
    nmap <silent> <unique> <leader>ma :ShowMarksClearAll<CR>
endif
if !hasmapto('<Plug>ShowmarksPlaceMark')
    nmap <silent> <unique> <leader>mm :ShowMarksPlaceMark<CR>
endif
nmap <unique> <script> \_M m
# 映射中调用全局函数
nmap <silent> m :exe 'norm \_M' .. nr2char(getchar()) <bar> call g:ShowMarks()<CR>

# ---- 自动命令 ----
if g:showmarks_enable == 1
    augroup ShowMarks
        au!
        autocmd CursorHold * call g:ShowMarks()
    augroup END
endif

# ---- 高亮 ----
highlight default ShowMarksHLl ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
highlight default ShowMarksHLu ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
highlight default ShowMarksHLo ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold
highlight default ShowMarksHLm ctermfg=darkblue ctermbg=blue cterm=bold guifg=blue guibg=lightblue gui=bold

# ---- 脚本局部变量 ----
var maxmarks: number = 0
var link_defs: dict<string> = {}   # nm -> highlight group name
var use_previous_include: bool = false
var use_new_include: bool = false

# ---- 辅助函数（脚本局部，无需前缀） ----
def GetMarkLine(mark: string): number
    # 返回标记所在行号（兼容 Vim 6/7）
    if v:version < 700
        return line(mark)
    endif
    const pos = getpos(mark)
    var lnum = pos[1]
    if pos[0] && bufnr('%') != pos[0]
        lnum = 0
    endif
    return lnum
enddef

def IncludeMarks(): string
    # 返回当前缓冲区要显示的标记列表（按优先级）
    if exists('b:showmarks_include') && exists('b:showmarks_previous_include')
        \ && b:showmarks_include != b:showmarks_previous_include
        if use_previous_include
            return b:showmarks_previous_include
        elseif use_new_include
            return b:showmarks_include
        else
            use_previous_include = true
            g:ShowMarksHideAll()
            use_previous_include = false
            use_new_include = true
            g:ShowMarks()
            use_new_include = false
        endif
    endif

    if !exists('g:showmarks_include')
        g:showmarks_include = ALL_MARKS
    endif
    if !exists('b:showmarks_include')
        b:showmarks_include = g:showmarks_include
    endif

    b:showmarks_previous_include = b:showmarks_include
    return b:showmarks_include
enddef

def NameOfMark(mark: string): string
    # 将非单词字符的标记转换为数字索引+10
    if mark =~# '\W'
        return string(stridx(ALL_MARKS, mark) + 10)
    endif
    return mark
enddef

def VerifyText(which: string)
    var txt: string
    if which == 'lower'
        txt = g:showmarks_textlower
    elseif which == 'upper'
        txt = g:showmarks_textupper
    elseif which == 'other'
        txt = g:showmarks_textother
    else
        return
    endif
    if txt == '' || strlen(txt) > 2
        echohl ErrorMsg
        echo $"ShowMarks: text{which} must contain only 1 or 2 characters."
        echohl None
        if which == 'lower'
            g:showmarks_textlower = '>'
        elseif which == 'upper'
            g:showmarks_textupper = '>'
        elseif which == 'other'
            g:showmarks_textother = '>'
        endif
    endif
enddef

def ShowMarksSetup()
    # 为所有标记定义 sign
    VerifyText('lower')
    VerifyText('upper')
    VerifyText('other')

    maxmarks = strlen(ALL_MARKS)
    link_defs = {}

    var n = 0
    while n < maxmarks
        var c = strpart(ALL_MARKS, n, 1)
        var nm = NameOfMark(c)
        var text = '>' .. c
        var lhltext = ''
        var hlgroup = ''

        if c =~# '[a-z]'
            var t = g:showmarks_textlower
            if strlen(t) == 1
                text = c .. t
            elseif strlen(t) == 2
                var t1 = strpart(t, 0, 1)
                var t2 = strpart(t, 1, 1)
                if t1 == "\t"
                    text = c .. t2
                elseif t2 == "\t"
                    text = t1 .. c
                else
                    text = t
                endif
            endif
            hlgroup = 'ShowMarksHLl'
            if g:showmarks_hlline_lower
                lhltext = 'linehl=' .. hlgroup .. nm
            endif
        elseif c =~# '[A-Z]'
            var t = g:showmarks_textupper
            if strlen(t) == 1
                text = c .. t
            elseif strlen(t) == 2
                var t1 = strpart(t, 0, 1)
                var t2 = strpart(t, 1, 1)
                if t1 == "\t"
                    text = c .. t2
                elseif t2 == "\t"
                    text = t1 .. c
                else
                    text = t
                endif
            endif
            hlgroup = 'ShowMarksHLu'
            if g:showmarks_hlline_upper
                lhltext = 'linehl=' .. hlgroup .. nm
            endif
        else
            var t = g:showmarks_textother
            if strlen(t) == 1
                text = c .. t
            elseif strlen(t) == 2
                var t1 = strpart(t, 0, 1)
                var t2 = strpart(t, 1, 1)
                if t1 == "\t"
                    text = c .. t2
                elseif t2 == "\t"
                    text = t1 .. c
                else
                    text = t
                endif
            endif
            hlgroup = 'ShowMarksHLo'
            if g:showmarks_hlline_other
                lhltext = 'linehl=' .. hlgroup .. nm
            endif
        endif
        link_defs[nm] = hlgroup

        exe 'sign define ShowMark' .. nm .. ' ' .. lhltext
            \ .. ' text=' .. text .. ' texthl=' .. hlgroup .. nm

		if !exists('b:showmarks_link')
			b:showmarks_link = {}
		endif
        b:showmarks_link[nm] = ''
        n += 1
    endwhile
enddef

# 初始化 sign 定义（内部调用）
ShowMarksSetup()

# ---- 全局函数（供外部调用） ----
def g:ShowMarksOn()
    if g:showmarks_enable == 0
        g:ShowMarksToggle()
    else
        g:ShowMarks()
    endif
enddef

def g:ShowMarksToggle()
    if g:showmarks_enable == 0
        g:showmarks_enable = 1
        g:ShowMarks()
        augroup ShowMarks
            au!
            autocmd CursorHold * call g:ShowMarks()
        augroup END
    else
        g:showmarks_enable = 0
        g:ShowMarksHideAll()
        augroup ShowMarks
            au!
            autocmd BufEnter * call g:ShowMarksHideAll()
        augroup END
    endif
enddef

def g:ShowMarks()
    if g:showmarks_enable == 0
        return
    endif

	if !exists('b:placed')
		b:placed = {}
    endif
    if !exists('b:showmarks_link')
        b:showmarks_link = {}
    endif

    # 忽略特定缓冲区类型
    if (match(g:showmarks_ignore_type, '[Hh]') > -1 && &buftype == 'help')
        \ || (match(g:showmarks_ignore_type, '[Qq]') > -1 && &buftype == 'quickfix')
        \ || (match(g:showmarks_ignore_type, '[Pp]') > -1 && &pvw)
        \ || (match(g:showmarks_ignore_type, '[Rr]') > -1 && &readonly)
        \ || (match(g:showmarks_ignore_type, '[Mm]') > -1 && !&modifiable)
        return
    endif

    var include_str = IncludeMarks()
    maxmarks = strlen(include_str)
    var mark_at: dict<string> = {}   # 行号 -> 标记名(nm)
    var bnr = winbufnr(0)

    var n = 0
    while n < maxmarks
        var c = strpart(include_str, n, 1)
        var nm = NameOfMark(c)
        var id = n + (maxmarks * bnr)
        var ln = GetMarkLine("'" .. c)

        if ln == 0 && (get(b:placed, nm, -1) != ln)
            exe 'sign unplace ' .. id .. ' buffer=' .. bnr
        elseif ln > 1 || c !~# '[a-zA-Z]'
            if has_key(mark_at, ln)
                # 该行已有标记，设为多标记高亮
                var existing_nm = mark_at[ln]
                if get(b:showmarks_link, existing_nm, '') != 'ShowMarksHLm'
                    b:showmarks_link[existing_nm] = 'ShowMarksHLm'
                    exe 'hi link ' .. link_defs[existing_nm] .. existing_nm
                        \ .. ' ' .. b:showmarks_link[existing_nm]
                endif
            else
                if get(b:showmarks_link, nm, '') != link_defs[nm]
                    b:showmarks_link[nm] = link_defs[nm]
                    exe 'hi link ' .. link_defs[nm] .. nm
                        \ .. ' ' .. b:showmarks_link[nm]
                endif
                mark_at[ln] = nm
                if ln > 0 && get(b:placed, nm, -1) != ln
                    exe 'sign unplace ' .. id .. ' buffer=' .. bnr
                    exe 'sign place ' .. id .. ' name=ShowMark' .. nm
                        \ .. ' line=' .. ln .. ' buffer=' .. bnr
					if !exists('b:placed')
						b:placed = {}
					endif
                    b:placed[nm] = ln
                endif
            endif
        endif
        n += 1
    endwhile
enddef

def g:ShowMarksClearMark()
    var ln = line('.')
    var include_str = IncludeMarks()
    maxmarks = strlen(include_str)

    var n = 0
    while n < maxmarks
        var c = strpart(include_str, n, 1)
        if c =~# '[a-zA-Z]' && ln == GetMarkLine("'" .. c)
            var nm = NameOfMark(c)
            var id = n + (maxmarks * winbufnr(0))
            exe 'sign unplace ' .. id .. ' buffer=' .. winbufnr(0)
            if v:version >= 700
                exe 'delm ' .. c
            else
                exe '1 mark ' .. c
            endif
			if !exists('b:placed')
				b:placed = {}
			endif
			b:placed[nm] = 1
        endif
        n += 1
    endwhile
enddef

def g:ShowMarksClearAll()
    var include_str = IncludeMarks()
    maxmarks = strlen(include_str)

    var n = 0
    while n < maxmarks
        var c = strpart(include_str, n, 1)
        if c =~# '[a-zA-Z]'
            var nm = NameOfMark(c)
            var id = n + (maxmarks * winbufnr(0))
            exe 'sign unplace ' .. id .. ' buffer=' .. winbufnr(0)
            if v:version >= 700
                exe 'delm ' .. c
            else
                exe '1 mark ' .. c
            endif
			if !exists('b:placed')
				b:placed = {}
			endif
			b:placed[nm] = 1
        endif
        n += 1
    endwhile
enddef

def g:ShowMarksHideAll()
    var include_str = IncludeMarks()
    maxmarks = strlen(include_str)

    var n = 0
    while n < maxmarks
        var c = strpart(include_str, n, 1)
        var nm = NameOfMark(c)
        if exists('b:placed') && has_key(b:placed, nm)
            var id = n + (maxmarks * winbufnr(0))
            exe 'sign unplace ' .. id .. ' buffer=' .. winbufnr(0)
            unlet b:placed[nm]
        endif
        n += 1
    endwhile
enddef

def g:ShowMarksPlaceMark()
    var include_str = IncludeMarks()
    maxmarks = strlen(include_str)
    var first_alpha_mark = -1
    var last_alpha_mark = -1
    var next_mark = -1

    if !exists('b:previous_auto_mark')
        b:previous_auto_mark = -1
	endif
    var n = 0
    while n < maxmarks
        var c = strpart(include_str, n, 1)
        if c =~# '[a-z]'
            if GetMarkLine("'" .. c) <= 1
                next_mark = n
                break
            endif
            if first_alpha_mark < 0
                first_alpha_mark = n
            endif
            last_alpha_mark = n
            if n > b:previous_auto_mark && next_mark == -1
                next_mark = n
            endif
        endif
        n += 1
    endwhile

    if next_mark == -1 && (b:previous_auto_mark == -1 || b:previous_auto_mark == last_alpha_mark)
        next_mark = first_alpha_mark
    endif

    if next_mark == -1
        echohl WarningMsg
        echo 'No marks in [a-z] included! (No "next mark" to choose from)'
        echohl None
        return
    endif

    var c = strpart(include_str, next_mark, 1)
    b:previous_auto_mark = next_mark
    exe 'mark ' .. c
    g:ShowMarks()
enddef

# ---- 初始化（如果启用） ----
if g:showmarks_enable
    g:ShowMarks()
endif

