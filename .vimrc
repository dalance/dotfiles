scriptencoding utf-8

"-------------------------------------------------------------------------------
" Initialize: {{{
"

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif
endif

function! s:Source(path)
    execute 'source' fnameescape(expand('dotfiles/' . a:path))
endfunction

let s:isWindows = has('win16') || has('win32') || has('win64')
function! IsWindows()
    return s:isWindows
endfunction

augroup vimrc
    autocmd!
augroup END

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoBundle: {{{
"

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Note: Add Bundles
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin'  : 'make -f make_cygwin.mak',
            \     'mac'     : 'make -f make_mac.mak',
            \     'linux'   : 'make',
            \     'unix'    : 'gmake',
            \ },
            \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/benchvimrc-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'taku-o/vim-vis'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'cespare/vim-toml'
NeoBundle 'chrisbra/SudoEdit.vim', { 'rev': 'e7fa13b' }
NeoBundle 'miyakogi/seiya.vim'
"NeoBundle 'phildawes/racer', {
"            \ 'build' : {
"            \   'mac' : 'cargo build --release',
"            \   'unix': 'cargo build --release',
"            \ },
"            \ }
NeoBundle 'plasticboy/vim-markdown'

if has('nvim')
    NeoBundleLazy 'Shougo/deoplete.nvim', {
        \ "autoload": { "insert": 1 }
        \ }
else
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ "autoload": { "insert": 1 }
        \ }
endif

if has('nvim')
    let s:hooks = neobundle#get_hooks("deoplete.nvim")
    function! s:hooks.on_source(bundle)
        let g:deoplete#enable_at_startup = 1
    endfunction
else
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    function! s:hooks.on_source(bundle)
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_ignore_case = 1
        let g:neocomplete#enable_smart_case = 1
    endfunction
endif


call neobundle#end()

filetype plugin indent on
syntax enable

if has('vim_starting')
    NeoBundleCheck
endif

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Plugins: {{{
"

"if neobundle#tap('neocomplete.vim') "{{{
"    let g:neocomplete#enable_at_startup = 1
"    let g:neocomplete#enable_ignore_case = 1
"    let g:neocomplete#enable_smart_case = 1
"endif "}}}

if neobundle#tap('unite.vim') "{{{
    let g:unite_source_history_yank_enable = 1
endif "}}}

if neobundle#tap('vinarise.vim') "{{{
    let g:vinarise_enable_auto_detect = 0
endif "}}}

if neobundle#tap('syntastic') "{{{
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_verilog_remove_include_errors = 1
    let g:syntastic_verilog_compiler_options = "-v *.include.v"
    let g:syntastic_scala_checkers = ["fsc"]
endif "}}}

if neobundle#tap('lightline.vim') "{{{
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
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
endif "}}}

if neobundle#tap('alpaca_tags') "{{{
    "let g:alpaca_tags#config = {
    "            \   '_': '-R --sort=yes'
    "            \ }
    let g:alpaca_tags#config = {
                \   '_': '-R'
                \ }
    let g:alpaca_tags#timeout_period = 0
    autocmd vimrc BufEnter * AlpacaTagsSet
    autocmd vimrc BufWritePost * AlpacaTagsUpdate
endif "}}}

if neobundle#tap('tmuxline.vim') "{{{
    "let g:tmuxline_preset = 'powerline'
    let g:tmuxline_preset = {
                \'a'       : '#(whoami)',
                \'b'       : '',
                \'c'       : '',
                \'win'     : '#I #W',
                \'cwin'    : '#I #W',
                \'x'       : ['#[fg=green,bold]#(cat /proc/loadavg | cut -d " " -f 1,2,3)', '#(uptime  | cut -d " " -f 3,4,5 | sed "s/,//g")'],
                \'y'       : ['#[fg=blue,bold]%R', '%m/%d', '%Y'],
                \'z'       : ['#[fg=black,bold]#H', '#(/sbin/ip -o -f inet addr | grep eth0 | cut -d " " -f 7)'],
                \'options' : {'status-justify' : 'left'}
                \ }
    let g:tmuxline_theme = 'powerline'
    let g:tmuxline_separators = {
                \ 'left' : '⮀',
                \ 'left_alt': '⮁',
                \ 'right' : '⮂',
                \ 'right_alt' : '⮃',
                \ 'space' : ' '}
endif "}}}

if neobundle#tap('rust.vim') "{{{
endif "}}}

if neobundle#tap('racer') "{{{
    let $RUST_SRC_PATH="/work/nhatta/ext_repo/rust/src/"
endif "}}}

if neobundle#tap('seiya.vim') "{{{
    let g:seiya_auto_enable = !has( 'gui_running' )
endif "}}}

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Encoding: {{{
"

" Setting of default encoding
set encoding=utf-8
set termencoding=utf-8

" The automatic recognition of the character code. {{{
if !exists('did_encoding_settings') && has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'

    " Does iconv support JIS X 0213?
    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213,euc-jp'
        let s:enc_jis = 'iso-2022-jp-3'
    endif

    " Build encodings.
    let &fileencodings = 'ucs-bom'
    if &encoding !=# 'utf-8'
        let &fileencodings .= ',' . 'ucs-2le'
        let &fileencodings .= ',' . 'ucs-2'
    endif
    let &fileencodings .= ',' . s:enc_jis
    let &fileencodings .= ',' . 'utf-8'

    if &encoding ==# 'utf-8'
        let &fileencodings .= ',' . s:enc_euc
        let &fileencodings .= ',' . 'cp932'
    elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
        let &encoding = s:enc_euc
        let &fileencodings .= ',' .  'cp932'
        let &fileencodings .= ',' .  &encoding
    else " cp932
        let &fileencodings .= ',' .  s:enc_euc
        let &fileencodings .= ',' .  &encoding
    endif
    let &fileencodings .= ',' .  'cp20932'

    unlet s:enc_euc
    unlet s:enc_jis

    let did_encoding_settings = 1
endif
" }}}

" When do not include Japanese, use encoding for fileencoding. {{{
function! s:ReCheck_FENC()
    let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
    if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
        let &fileencoding = &encoding
    endif
endfunction

autocmd vimrc BufReadPost * call s:ReCheck_FENC()
" }}}

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
" A fullwidth character is displayed in vim properly.
set ambiwidth=double
"set ambiwidth=single

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Search: {{{
"

" Ignore the case of normal letters.
"set ignorecase
" If the search pattern contains upper case characters, override ignorecase option.
set smartcase

" Enable incremental search.
set incsearch
" Don't highlight search result.
set nohlsearch

" Searches wrap around the end of the file.
set wrapscan

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Edit: {{{
"

" Enable indent
"set autoindent
"set smartindent
set cindent

" Smart insert tab setting
set smarttab
" Exchange tab to spaces.
set expandtab
" Substitute <Tab> with blanks.
set tabstop=4
" Spaces instead <Tab>.
set softtabstop=4
" Autoindent width.
set shiftwidth=4
" Round indent by shiftwidth.
set shiftround

" Enable modeline.
set modeline

" Disable auto wrap.
autocmd vimrc FileType * set textwidth=0

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

"" Highlight parenthesis.
"set showmatch
"" Highlight when CursorMoved.
"set cpoptions-=m
"set matchtime=0
"" Highlight <>.
"set matchpairs+=<:>
"set matchpairs=

" Auto reload if file is changed.
"set autoread

" Ignore case on insert completion.
set infercase

" Enable folding.
set foldenable
set foldmethod=marker
set foldcolumn=4
set fillchars=vert:\|
set commentstring=%s

" = をファイル名の一部と認識しない
set isfname-==

" Reload .vimrc automatically
autocmd vimrc BufWritePost .vimrc,vimrc,vimrc_* source $MYVIMRC | echo "source $MYVIMRC"

" Set swap directory
set directory-=.

" Enable virtualedit in visual block mode.
set virtualedit=block

" undofile
if has('persistent_undo')
    set undofile
    set undodir=~/.vimundo
endif

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" View: {{{
"

" Show <TAB> and <CR>
set list
set listchars=tab:>-,extends:>,precedes:<,trail:~

" Always display statusline.
set laststatus=2
" Height of command line.
set cmdheight=2
" Not show command on statusline.
set noshowcmd


" Disable bell.
set novisualbell
set t_vb=

" Display candidate supplement.
set nowildmenu
set wildmode=list:longest,full
" Increase history amount.
set history=200
" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag
set notagbsearch
" Can supplement a tag in a command-line.
set wildoptions=tagfile

" Enable multibyte format.
set formatoptions+=mM

" Don't redraw while macro executing
set lazyredraw
set ttyfast

" Don't create backup
set nobackup
set writebackup

set background=dark
colorscheme hybrid
"hi MatchParen ctermbg=LightGray

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" FileType: {{{
"

" python
autocmd vimrc FileType python if has('python')  | setlocal omnifunc=pythoncomplete#Complete  | endif
autocmd vimrc FileType python if has('python3') | setlocal omnifunc=python3complete#Complete | endif
"autocmd vimrc FileType python setlocal foldmethod=indent

" verilog
autocmd vimrc BufNewFile,BufRead *.v,*.vh,*.sv,*.svi,*.vp set filetype=verilog

" asmxyz
autocmd vimrc BufNewFile,BufRead *.s,*.asm,*.txt set filetype=asmxyz

" nz
autocmd vimrc BufNewFile,BufRead *.nz set filetype=nz

" liberty
autocmd vimrc BufNewFile,BufRead *.lib set filetype=liberty

" llvm
autocmd vimrc BufNewFile,BufRead *.ll set filetype=llvm
autocmd vimrc BufNewFile,BufRead *.td set filetype=tablegen

" xaml
autocmd vimrc BufNewFile,BufRead *.xaml set filetype=xml

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Mappings: {{{
"

" <ESC> {{{
nnoremap <silent> <C-j> <ESC>
inoremap <silent> <C-j> <ESC>
vnoremap <C-j> <Nop>
"}}}

" <BS> {{{
noremap   
noremap!  
noremap  <BS> 
noremap! <BS> 
"}}}

" tag jump {{{
nnoremap <C-]> g<C-]>
"}}}

" remove {{{
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q  <Nop>
"}}}

if neobundle#tap('unite.vim') "{{{
    nnoremap [unite] <Nop>
    nmap <Space> [unite]
    nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
    nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
    nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
    nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>

    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-h> unite#do_action('vsplit')
endif "}}}

if neobundle#tap('vim-anzu') "{{{
    nmap n <Plug>(anzu-n)
    nmap N <Plug>(anzu-N)
    nmap * <Plug>(anzu-star)
    nmap # <Plug>(anzu-sharp)
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
    vmap <Enter> <Plug>(EasyAlign)
endif "}}}

" command line buffer {{{
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap : <SID>(command-line-enter)
xmap : <SID>(command-line-enter)

autocmd vimrc CmdwinEnter * call s:InitCmdwin()

function! s:InitCmdwin()
    nnoremap <buffer><silent> q :<C-u>quit<CR>
    nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>

    if neobundle#tap('neocomplete.vim') "{{{
        inoremap <buffer><expr><CR> neocomplete#close_popup()."\<CR>"
        inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
        inoremap <buffer><expr><BS> col('.') == 1 ? "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
    endif "}}}

    if neobundle#tap('deoplete.nvim') "{{{
        inoremap <buffer><expr><CR> deoplete#mappings#close_popup()."\<CR>"
        inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : deoplete#mappings#cancel_popup()."\<C-h>"
        inoremap <buffer><expr><BS> col('.') == 1 ? "\<ESC>:quit\<CR>" : deoplete#mappings#cancel_popup()."\<C-h>"
    endif "}}}

    "inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>\<C-p>"
    inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"

    silent execute printf("1,%ddelete _", max([0,min([&history - 20, line("$") - 20])]))
    call cursor(line('$'), 0)

    startinsert!
endfunction

"}}}

" continuous number {{{
nnoremap <silent> cu :ContinuousCmd <C-a><CR>
vnoremap <silent> cu :ContinuousCmd <C-a><CR>
nnoremap <silent> cd :ContinuousCmdRev <C-a><CR>
vnoremap <silent> cd :ContinuousCmdRev <C-a><CR>
command! -count -nargs=1 ContinuousCmd    :call s:ContinuousCmd(<count>, <q-args>, 0)
command! -count -nargs=1 ContinuousCmdRev :call s:ContinuousCmd(<count>, <q-args>, 1)

function! s:ContinuousCmd(count, cmd, rev)
    let snf=&nrformats
    set nrformats-=octal
    let cl = col('.')
    for nc in range(1, a:count?a:count-line('.'):1)
        if a:rev == 1
            exe 'normal! ' . (a:count?a:count-line('.'):1 - nc + 1) . a:cmd . 'j'
        else
            exe 'normal! j' . nc . a:cmd
        endif
        call cursor('.', cl)
    endfor
    unlet cl
    unlet snf
endfunction
"}}}

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Platform: {{{
"

set shell=zsh
set t_Co=256

" Use vsplit mode {{{
if has("vim_starting") && !has('gui_running') && has('vertsplit')
    function! g:EnableVsplitMode()
        " enable origin mode and left/right margins
        let &t_CS = "y"
        let &t_ti = &t_ti . "\e[?6;69h"
        let &t_te = "\e[?6;69l\e[999H" . &t_te
        let &t_CV = "\e[%i%p1%d;%p2%ds"
        call writefile([ "\e[?6;69h" ], "/dev/tty", "a")
    endfunction

    " old vim does not ignore CPR
    map <special> <Esc>[3;9R <Nop>

    " new vim can't handle CPR with direct mapping
    " map <expr> [3;3R g:EnableVsplitMode()
    set t_F9=[3;3R
    map <expr> <t_F9> g:EnableVsplitMode()
    let &t_RV .= "\e[?6;69h\e[1;3s\e[3;9H\e[6n\e[0;0s\e[?6;69l"
endif
"}}}

"
" }}}
"-------------------------------------------------------------------------------

" vim: foldmethod=marker

