if dein#tap('neomake')
    autocmd vimrc BufWritePost,BufEnter * Neomake
    autocmd vimrc QuitPre * let g:neomake_verbose = 0
    let g:neomake_python_enabled_makers = []
endif
