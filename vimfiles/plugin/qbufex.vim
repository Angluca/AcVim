vim9script
# qbufex.vim -- Vim9版
# 默认 <F4> 打开qbufex (可用 g:qb_hotkey设置快捷键):
# - j/k 或方向键移动, J/K 翻5行, g/G 到顶/到尾
# - 数字+动作键对指定 buffer 执行动作(如 3d), 数字省略则作用于选中行
# - Space/Enter跳转，q/<C-c>/<Esc> 退出
# - z/f 切换, !f/F 强制切换, s/v 水平/垂直split
# - e 隐藏式切换(hid b), d/D 删除(bd/bd!), w/W/!w 擦除(bw/bw!)
# - l 切换 listed/unlisted 列表, c 关闭该 buffer 所在窗口


if !exists('g:qb_hotkey') || g:qb_hotkey == ''
  g:qb_hotkey = '<F4>'
endif

var buflist: list<string> = []
var blen: number = 0
var unlisted = false 
var cursel: number = 0
var cmdh: number = &cmdheight
var hasMore: bool = &more  
var cursorbg = ''
var cursorfg = ''
var klist = ['j', 'J', 'k', 'K', 'g', 'G', 'f', 'F', 'e', 'd', 'D', 'w', 'W', 'l', 's', 'v', 'c', 'q', 'z']

def GetStarBuf(): number
  var idx = match(buflist, '^\d*\*')
  if idx == -1
    return 0
  endif
  return str2nr(matchstr(buflist[idx], '<\zs\d\+\ze>'))
enddef

def SwitchBuf(bno: number, mod: string)
  if bufwinnr(bno) == -1
    exe $'b{mod} {bno}'
  else
    exe $"{bufwinnr(bno)}winc w"
  endif
enddef

def SplitBuf(bno: number, mod: string)
  exe $'sb {bno}'
enddef

def VSplitBuf(bno: number, mod: string)
  exe $'vert sb {bno}'
enddef

def HideEdit(bno: number, mod: string)          # e: hid b + 选中行下移
  exe $'hid b {bno}'
  cursel = (cursel + 1) % blen
enddef

def DelBuf(bno: number, mod: string)            # d: unlisted 时改为恢复 listed
  if unlisted
    setbufvar(bno, '&buflisted', 1)
  else
    exe $'bd{mod} {bno}'
  endif
enddef

def WipeBuf(bno: number, mod: string)           # w
  exe $'bw{mod} {bno}'
enddef

def CloseWin(bno: number, mod: string)          # c
  var wn = bufwinnr(bno)
  if wn != -1
    exe $"{wn}winc w"
    exe 'close'
  endif
enddef

def ToggleList(bno: number, mod: string)        # l
  unlisted = !unlisted
enddef

# F/D/W 等价于带 ! 的版本，mod 由 UpdateBuf 统一算出传入
var action2func: dict<func> = {
  'z': SwitchBuf, '!z': SwitchBuf,
  'f': SwitchBuf, '!f': SwitchBuf, 'F': SwitchBuf,
  's': SplitBuf, 'v': VSplitBuf, 'e': HideEdit,
  'd': DelBuf, '!d': DelBuf, 'D': DelBuf,
  'w': WipeBuf, '!w': WipeBuf, 'W': WipeBuf,
  'l': ToggleList, 'c': CloseWin,
}

# ---------- 列表重建 ----------

def Rebuild()
  buflist = []
  blen = 0
  for theline in execute('silent ls!')->split("\n")
    if len(theline) < 8           # 过滤尾部空行，避免越界索引
      continue
    endif
    var isunl = theline[3] == 'u'
    if unlisted && isunl && (theline[6] != '-' || theline[5] != ' ') || !unlisted && !isunl
      var moreinfo: string
      if unlisted
        moreinfo = substitute(theline[5], '[ah]', ' [+]', '')
      else
        moreinfo = substitute(theline[7], '+', ' [+]', '')
      endif
      blen += 1
      var fname = matchstr(theline, '"\zs[^"]*')
      var bufnum = matchstr(theline, '^ *\zs\d*')
      var active = '  '
      if str2nr(bufnum) == bufnr()
        active = '* '
      elseif bufwinnr(str2nr(bufnum)) > 0
        active = '= '
      endif
      add(buflist, blen .. active
            .. fnamemodify(fname, ':t') .. moreinfo
            .. ' <' .. bufnum .. '> '
            .. fnamemodify(fname, ':h'))
    endif
  endfor

  if !buflist->empty()
    var alignsize = max(buflist->copy()->map((_, val) => stridx(val, '>')))
    map(buflist, (_, val) => substitute(val, ' <', repeat(' ', alignsize - stridx(val, '>')) .. ' <', ''))
    map(buflist, (_, val) => strpart(val, 0, &columns - 3))
  endif
enddef

# ---------- 主流程 ----------

def SBRun()
  if cursel >= blen || cursel < 0
    cursel = blen - 1
  endif
  set nomore

  if blen < 1
    echohl WarningMsg
    echo 'No ' .. (unlisted ? 'unlisted' : 'listed') .. ' buffer!'
    echohl None
    Init(0)
    return
  endif

  for idx in range(blen)
    if idx != cursel
      echo '  ' .. buflist[idx]
    else
      echohl DiffText
      echo '> ' .. buflist[idx]
      echohl None
    endif
  endfor

  if unlisted
    echohl WarningMsg
  endif
  var pkey = input(unlisted ? 'UNLISTED ([+] loaded):' : 'LISTED ([+] modified):', ' ')
  if unlisted
    echohl None
  endif

  if pkey =~# 'j$'
    cursel = (cursel + 1) % blen
  elseif pkey =~# 'k$'
    cursel = cursel == 0 ? blen - 1 : cursel - 1
  elseif pkey =~# 'J$'
    cursel = min([cursel + 5, blen])
  elseif pkey =~# 'K$'
    cursel = max([cursel - 5, 0])
  elseif pkey =~# 'G$'
    cursel = blen
  elseif pkey =~# 'g$'
    cursel = 0
  elseif UpdateBuf(pkey)
    Init(0)
    if hasMore
      set more
    endif
    return
  endif
  SetCmdh(blen + 1)
enddef

def UpdateBuf(cmd: string): bool
  if cmd != '' && cmd =~# '^ *\d*!\?\a\?$'
    var bufidx = str2nr(cmd) - 1
    if bufidx == -1
      bufidx = cursel
    endif
    var action = matchstr(cmd, '!\?\a\?$')
    #echowindow $"test: {cmd}--{action}"
    if action == ''
      action ..= 'f'
    elseif action == '!'
      action ..= 'z'
    endif
    if bufidx >= 0 && bufidx < blen && has_key(action2func, action)
      var bufnum = str2nr(matchstr(buflist[bufidx], '<\zs\d\+\ze>'))
      var mod = action[0] == '!' || index(['F', 'D', 'W'], action) >= 0 ? '!' : ''
      action = tolower(action)
      try
        action2func[action](bufnum, mod)
        if action[-1 :] != 'z'
          Rebuild()
        endif
      catch
        #echowindow $"test: {bufnum}-{mod}--{action}"
        if action[-1 :] == 'f' # && GetStarBuf() != bufnr()
          Rebuild()
        elseif action[-1 :] != 'z'
          inputsave()
          getchar()
          inputrestore()
        endif
      endtry
    endif
  endif
  return index(klist, cmd == '' ? '' : cmd[-1 :]) == -1
enddef

def SetCmdh(height: number)
  if height > &lines - winnr('$') * (&winminheight + 1) - 1
    &cmdheight = 1                # 放不下时至少保留一行
  else
    &cmdheight = height
  endif
enddef

def Init(onStart: number)
  if onStart != 0
    set nolazyredraw
    unlisted = !getbufvar('%', '&buflisted')
    cursorbg = synIDattr(hlID('Cursor'), 'bg')
    cursorfg = synIDattr(hlID('Cursor'), 'fg')
    cmdh = &cmdheight

    for key in klist
      if key == 'q'
        exe $"cnoremap {key} :call <SID>Init(0)<cr>:echo ''<cr>"
      else
        exe $"cnoremap {key} {key}<cr>:call <SID>SBRun()<cr>"
      endif
    endfor
    cmap <up> k
    cmap <down> j
    cnoremap <space> <cr>
    exe "cnoremap <c-c> :call <SID>Init(0)<cr>:echo ''<cr>"

    Rebuild()
    cursel = match(buflist, '^\d*\*') - 1   # 初始选中当前buf-1=不同buf
    SetCmdh(blen + 1)
  else
    var bufidx = GetStarBuf()
    if bufidx != 0 && bufidx != bufnr() && bufexists(bufidx)
      SwitchBuf(bufidx, '')
    endif
    SetCmdh(cmdh)
    for key in klist
      exe $'cunmap {key}'
    endfor
    cunmap <up>
    cunmap <down>
    cunmap <space>
    cunmap <c-c>
  endif
enddef

exe $"nnoremap <unique> {g:qb_hotkey} :call <SID>Init(1)<CR>:call <SID>SBRun()<CR>"

