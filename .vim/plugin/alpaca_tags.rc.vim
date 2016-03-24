let g:alpaca_tags#config = {
            \   '_': '-R'
            \ }
let g:alpaca_tags#timeout_period = 0
autocmd vimrc BufEnter * AlpacaTagsSet
autocmd vimrc BufWritePost * AlpacaTagsUpdate
