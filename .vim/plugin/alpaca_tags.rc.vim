let g:alpaca_tags#ctags_bin = "ptags"
let g:alpaca_tags#config = {
            \   '_': '--exclude-lfs -c=--links=no -c=--tag-relative=never -c=--options=/home/hatta/.ctags',
            \ }
let g:alpaca_tags#timeout_period = 0
autocmd vimrc BufEnter     * AlpacaTagsSet
autocmd vimrc BufWritePost * AlpacaTagsUpdate
