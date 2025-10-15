" Add the `end` for the code on the current line
function! s:EndToken()
  let current_line = getline( '.' )
  let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  if match( current_line, braces_at_end ) >= 0
    return '}'
  else
    return 'end'
  endif
endfunction

inoremap <Localleader><space><CR> <ESC>:execute 'normal o' . <SID>EndToken()<CR>O
