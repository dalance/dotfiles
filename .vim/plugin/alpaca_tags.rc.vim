let g:alpaca_tags#config = {
            \   '_': '-R --exclude=*.mapped.link.v --exclude=*.mapped.v --exclude=run_dir --exclude=csrc --exclude=simv.daidir',
            \ }
let g:alpaca_tags#timeout_period = 0
autocmd vimrc BufEnter     * AlpacaTagsSet
autocmd vimrc BufWritePost * AlpacaTagsUpdate
