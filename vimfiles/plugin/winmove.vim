vim9script

scriptencoding utf-8
if !has('gui_running')
    finish
endif

if !exists('g:wm_move_up')
    g:wm_move_up = '<m-Up>'
endif
if !exists('g:wm_move_right')
    g:wm_move_right = '<m-Right>'
endif
if !exists('g:wm_move_down')
    g:wm_move_down = '<m-Down>'
endif
if !exists('g:wm_move_left')
    g:wm_move_left = '<m-Left>'
endif
if !exists('g:wm_move_x')
    g:wm_move_x = 20
endif
if !exists('g:wm_move_y')
    g:wm_move_y = 15
endif

# 脚本局部函数，无需前缀
def MoveTo(dest: string)
    var winpos = {
        x: getwinposx(),
        y: getwinposy()
    }
    var repeat_count: number = v:count1

    if dest == '>'
        winpos.x += g:wm_move_x * repeat_count
    elseif dest == '<'
        winpos.x -= g:wm_move_x * repeat_count
    elseif dest == '^'
        winpos.y -= g:wm_move_y * repeat_count
    elseif dest == 'v'
        winpos.y += g:wm_move_y * repeat_count
    endif

    exe 'winpos' winpos.x winpos.y
enddef

var mappings = {
    '^': g:wm_move_up,
    '>': g:wm_move_right,
    'v': g:wm_move_down,
    '<': g:wm_move_left
}
for key in keys(mappings)
    if mappings[key] != ''
        exe 'nnoremap <silent>' mappings[key]
            \ .. ' <ScriptCmd>MoveTo(' .. string(key) .. ')<CR>'
    endif
endfor

