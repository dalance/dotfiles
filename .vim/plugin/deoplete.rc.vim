" <TAB>: completion.
imap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"}}}

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
"  return deoplete#mappings#close_popup() . "\<CR>"
"endfunction

autocmd BufRead * call s:check_large_file()

function! s:check_large_file() abort "{{{
  let ret = wordcount()
  if ret['bytes'] > 10 * 1024 * 1024
    "echo 'Disabled deoplete source( buffer, member ) at large file:' ret['bytes'] 'byte'
    "call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'member']})
  endif
endfunction
"}}}

let g:deoplete#enable_refresh_always = 1
