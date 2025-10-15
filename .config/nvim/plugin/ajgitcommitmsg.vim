function! AJGitCommitMsg()
    " Check that this is, in fact, a commit message
    let s:commit_msg = expand('%:t')
    if s:commit_msg !=# 'COMMIT_EDITMSG'
        return
    endif

    " If git pre-populated text, then don't add ticket info
    let s:first_line = getline(1)
    if len(s:first_line) != 0
        return
    endif

    let s:full_branch = system('git symbolic-ref --short HEAD')
    let s:parsed_ticket = substitute(s:full_branch,
        \ '\v\C^(.{-}[-/]){-}([a-zA-Z]{2,7}-[0-9]+)(-.+)*\n$', '\U\2\E', '')

    " If our branch didn't change, then nothing to do here
    if s:full_branch ==# s:parsed_ticket
        return
    endif

    " Insert the parsed ticket info in square brackets and a trailing space
    execute "normal! i[" . s:parsed_ticket . "] "
endfunction
