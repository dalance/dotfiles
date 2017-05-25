scriptencoding utf-8

"-------------------------------------------------------------------------------
" Initialize: {{{
"

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
    set nocompatible
endif

if has('vim_starting')
    let s:is_windows = has('win32') || has('win64')

    function! IsWindows() abort
        return s:is_windows
    endfunction

    " Use <Leader> in global plugin.
    let g:mapleader = ','

    if IsWindows()
        " Exchange path separator.
        set shellslash
    endif

    let $CACHE = expand('~/.cache')

    if !isdirectory(expand($CACHE))
        call mkdir(expand($CACHE), 'p')
    endif

    " Set augroup.
    augroup vimrc
        autocmd!
    augroup END

    " Load dein.
    let s:dein_dir = finddir('dein.vim', '.;')
    if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
        if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
            let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'
            if !isdirectory(s:dein_dir)
                execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
            endif
        endif
        "execute ' set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
        execute ' set runtimepath+=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
    endif

    "set runtimepath+=~/work/vseq.vim
    " Disable menu.vim.
    if has('gui_running')
       set guioptions=Mc
    endif

    " Disable default plugins. {{{
    let g:loaded_rrhelper          = 1
    let g:loaded_2html_plugin      = 1
    let g:loaded_vimball           = 1
    let g:loaded_vimballPlugin     = 1
    let g:loaded_getscript         = 1
    let g:loaded_getscriptPlugin   = 1
    "let g:loaded_netrw             = 1
    "let g:loaded_netrwPlugin       = 1
    "let g:loaded_netrwSettings     = 1
    "let g:loaded_netrwFileHandlers = 1
    let g:loaded_matchparen        = 1
    let g:loaded_LogiPat           = 1
    let g:loaded_logipat           = 1
    let g:loaded_tutor_mode_plugin = 1
    let g:loaded_spellfile_plugin  = 1
    let g:loaded_man               = 1
    let g:loaded_matchit           = 1
    " }}}

    let g:python3_host_prog = expand('$HOME') . '/.linuxbrew/bin/python3'
endif

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Dein: {{{
"

let g:dein#install_progress_type = 'title'

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
    let s:toml_path = '~/.vim/plugin/dein.toml'
    let s:toml_lazy_path = '~/.vim/plugin/deinlazy.toml'

    call dein#begin(s:path, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])

    call dein#load_toml(s:toml_path, {'lazy': 0})
    call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    " Installation check.
    call dein#install()
endif

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Plugins: {{{
"

if dein#tap('deoplete.nvim') && has('nvim')
    let g:loaded_neocomplete = 1
endif

if dein#tap('neocomplete.vim') && has('lua')
    let g:loaded_deoplete = 1
endif
let g:loaded_neobundle = 1

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Encoding: {{{
"

" Setting of default encoding
if has('vim_starting')
    set encoding=utf-8
    set termencoding=utf-8
endif

" The automatic recognition of the character code."{{{
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
"}}}

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() abort "{{{
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction
"}}}

autocmd vimrc BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

if has('multi_byte_ime')
    set iminsert=0 imsearch=0
endif

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
set showmatch
"" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=1
"" Highlight <>.
set matchpairs+=<:>

" Auto reload if file is changed.
"set autoread

" Ignore case on insert completion.
set infercase

" Enable folding.
"set foldenable
"set foldmethod=marker
"set foldcolumn=4
"set fillchars=vert:\|
"set commentstring=%s

" = をファイル名の一部と認識しない
set isfname-==

" Set swap directory
set directory-=.

" Enable virtualedit in visual block mode.
set virtualedit=block

" undofile
if has('persistent_undo')
    set undofile
    set undodir=~/.vimundo
endif

set mouse=""

" Don't create backup
set nobackup
set writebackup

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" View: {{{
"

" Show <TAB> and <CR>
set list
if IsWindows()
    set listchars=tab:>-,trail:-,extends:>,precedes:<
else
    set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif

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
set history=1000
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

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" FileType: {{{
"

" Enable smart indent.
set autoindent smartindent

" Reload .vimrc automatically.
autocmd vimrc BufWritePost .vimrc,vimrc,*.rc.vim,dein.toml,deinlazy.toml nested | source $MYVIMRC | redraw

" verilog -> systemverilog
autocmd vimrc BufNewFile,BufRead *.v,*.vh,*.vp set filetype=systemverilog

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

silent! filetype plugin indent on
syntax enable
filetype detect

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

" gg {{{
nnoremap gg 1<C-v>
"}}}

if dein#tap('unite.vim') "{{{
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

if dein#tap('denite.nvim') "{{{
    nnoremap [denite] <Nop>
    nmap <Space> [denite]
    nnoremap <silent> [denite]f :<C-u>Denite<Space>file<CR>
    nnoremap <silent> [denite]g :<C-u>Denite<Space>grep<CR>
    nnoremap <silent> [denite]m :<C-u>Denite<Space>-mode=normal<Space>file_mru<CR>
    nnoremap <silent> [denite]h :<C-u>Denite<Space>neoyank<CR>

	call denite#custom#map('_'     , "\<C-p>", 'move_to_prev_line')
	call denite#custom#map('_'     , "\<C-n>", 'move_to_next_line')
	call denite#custom#map('insert', "\<C-j>", '<denite:enter_mode:normal>')
	call denite#custom#map('normal', "\<C-j>", '<denite:do_action:split>')
    "autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    "autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    "autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('vsplit')
    "autocmd FileType unite inoremap <silent> <buffer> <expr> <C-h> unite#do_action('vsplit')
endif "}}}

if dein#tap('vim-anzu') "{{{
    nmap n <Plug>(anzu-n)
    nmap N <Plug>(anzu-N)
    nmap * <Plug>(anzu-star)
    nmap # <Plug>(anzu-sharp)
endif "}}}

if dein#tap('vim-easy-align') "{{{
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

    "if dein#tap('neocomplete.vim') "{{{
    "    inoremap <buffer><expr><CR> neocomplete#close_popup()."\<CR>"
    "    inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
    "    inoremap <buffer><expr><BS> col('.') == 1 ? "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
    "endif "}}}

    if dein#tap('deoplete.nvim') "{{{
        "inoremap <buffer><expr><CR> deoplete#mappings#close_popup()."\<CR>"
        inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : deoplete#mappings#cancel_popup()."\<C-h>"
        inoremap <buffer><expr><BS> col('.') == 1 ? "\<ESC>:quit\<CR>" : deoplete#mappings#cancel_popup()."\<C-h>"
    endif "}}}

    inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
    "inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"

    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
    "}}}

    silent execute printf("1,%ddelete _", max([0,min([&history - 20, line("$") - 20])]))
    call cursor(line('$'), 0)

    startinsert!
endfunction

"}}}

if dein#tap('vseq.vim') "{{{
    vmap cud <Plug>(operator-vseq-incr-dec)
    vmap cdd <Plug>(operator-vseq-decr-dec)
    vmap cuh <Plug>(operator-vseq-incr-hex)
    vmap cdh <Plug>(operator-vseq-decr-hex)
endif "}}}

"
" }}}
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Platform: {{{
"

set shell=zsh
set t_Co=256

if has('nvim')
    " Use cursor shape feature.
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

    " Use true color feature.
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

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

set background=dark
colorscheme hybrid

"
" }}}
"-------------------------------------------------------------------------------

" vim: foldmethod=marker

