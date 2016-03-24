let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified', 'anzu'] ],
    \   'right': [ ['lineinfo', 'syntastic'], ['percent'], ['fileformat', 'fileencoding', 'filetype'] ]
    \ },
    \ 'component': {
    \   'lineinfo': '⭡ %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'syntastic': 'SyntasticStatuslineFlag',
    \   'anzu': 'anzu#search_status'
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
    \ }
function! LightlineReadonly()
    return &readonly ? '⭤' : ''
endfunction
