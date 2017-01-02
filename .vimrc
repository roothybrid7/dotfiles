" --------------------------------------------------------------------------------
" Encodings
" --------------------------------------------------------------------------------
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
set fileformats=unix,dos

let &termencoding = &encoding
set encoding=utf-8
set fileformat=unix
if exists('&ambiwidth')
    set ambiwidth=double
endif

" --------------------------------------------------------------------------------
"  Base
" --------------------------------------------------------------------------------
set confirm
set hidden	" Disable prompt on unsaved file
set autoread
set backspace=indent,eol,start
set whichwrap=b,s,[,],<,>
set clipboard&
set clipboard^=unnamedplus
if has('mouse')
    set mouse=a
endif
set history=10000
set virtualedit=block
set lazyredraw
set shellslash

" --------------------------------------------------------------------------------
" Display settings
" --------------------------------------------------------------------------------
set number
set cursorline
set showmatch
set ruler
set title
set list
set listchars=tab:^\ ,trail:~
set foldmethod=syntax
set foldlevel=100		"Don't autofold anything
set wrap

" --------------------------------------------------------------------------------
" Search
" --------------------------------------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault
nmap <Space><Space> :noh<CR>

" --------------------------------------------------------------------------------
" Tab/Indent
" --------------------------------------------------------------------------------
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set cinoptions+=:0
set smarttab
set formatoptions-=c

augroup vimrc
    au Filetype python,java,m,objective-c
                \ setlocal tw=80 cc=80
    au Filetype go
                \ setlocal noexpandtab
    au Filetype c,c++,cpp
                \ setlocal noexpandtab tw=72 cc=72
    au Filetype yaml,css,eruby,feature,sass,json,scss,sass
                \ setlocal sts=2 sw=2 ts=2 tw=80 cc=80
    au Filetype html,xhtml
                \ setlocal sts=2 sw=2 ts=2
    au Filetype sh,xml,haml,ejs,erb,jade,sql,sh,zsh,bash,vim,csv
                \ setlocal sts=2 sw=2 ts=2
    au Filetype ruby,puppet,coffee,javascript,diag
                \ setlocal sts=2 sw=2 ts=2 tw=80 cc=80
augroup END

" --------------------------------------------------------------------------------
" Status  line
" --------------------------------------------------------------------------------
set showcmd
set laststatus=2
set cmdheight=2
set statusline=[%n]
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
set statusline+=%<%F
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=[%{&fileformat}]
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=%y
set statusline+=%=
set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
set statusline+=[C=%c/%{col('$')-1}]
set statusline+=[L=%l/%L]
set wildmenu
set display=lastline


" --------------------------------------------------------------------------------
" Paste
" --------------------------------------------------------------------------------
au InsertEnter * set paste
au InsertLeave * set nopaste

if has("unix")
    let s:uname = system("echo -n $(uname -s)")
    if s:uname == "Darwin"
        nnoremap <silent> <Space>y :.w !pbcopy<CR><CR>
        vnoremap <silent> <Space>y :w !pbcopy<CR><CR>
        nnoremap <silent> <Space>p :r !pbpaste<CR>
        vnoremap <silent> <Space>p :r !pbpaste<CR>
    else
        noremap <Space>y "+y
        noremap <Space>p "+p
    endif
endif

" --------------------------------------------------------------------------------
" Last cursor position on reopen
" --------------------------------------------------------------------------------
augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line('$') |
                \   exe "normal! g`\"" |
                \ endif
augroup END

" --------------------------------------------------------------------------------
" Change color at insert mode.
" --------------------------------------------------------------------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
    syntax on
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
    if a:mode == 'Enter'
        silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight '.a:hi
    redir END
    let hl = substitute(hl, '[\r\n]', '', 'g')
    let hl = substitute(hl, 'xxx', '', '')
    return hl
endfunction

" --------------------------------------------------------------------------------
" Visiblity double width space.
" --------------------------------------------------------------------------------
if has('syntax')
    syntax on
    function! ActivateInvisibleIndicator()
        highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
        silent! match ZenkakuSpace /ã/
    endfunction
    augroup InvisibleIndicator
        autocmd!
        autocmd VimEnter,BufEnter * call ActivateInvisibleIndicator()
    augroup END
endif

" --------------------------------------------------------------------------------
" Grammer mappings
" --------------------------------------------------------------------------------
au BufNewFile,BufRead Podfile,*.podspec set ft=ruby
au BufNewFile,BufRead Capfile,Rakefile,Gemfile,Guardfile set ft=ruby
au BufNewFile,BufRead config.ru set ft=ruby

au BufNewFile,BufRead .xctool-args,jshintrc set ft=json

au BufNewFile,BufRead *.diag set ft=diag

au BufNewFile,BufRead *.dicon set ft=xml
au BufNewFile,BufRead *.plist set ft=xml

au BufNewFile,BufRead *.scss set ft=css
au BufNewFile,BufRead *.scss set ft=scss

au BufNewFile,BufRead *.conf set ft=cfg
au BufNewFile,BufRead *.toml set ft=cfg

au BufNewFile,BufRead Cartfile set filetype=swift
au BufNewFile,BufRead *.stencil set filetype=swift

" --------------------------------------------------------------------------------
" diff
" --------------------------------------------------------------------------------
map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>

" --------------------------------------------------------------------------------
" Moves
" --------------------------------------------------------------------------------
nnoremap <silent>bp :bprevious<CR>
nnoremap <silent>bn :bnext<CR>
nnoremap <silent>tn :tabnew<CR>
nnoremap <silent>tc :tabc<CR>

" --------------------------------------------------------------------------------
" GZip
" --------------------------------------------------------------------------------
augroup gzip
 au!
 au BufReadPre,FileReadPre *.gz set bin
 au BufReadPost,FileReadPost   *.gz '[,']!gunzip
 au BufReadPost,FileReadPost   *.gz set nobin
 au BufReadPost,FileReadPost   *.gz execute ":doautocmd BufReadPost " . expand("%:r")
 au BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
 au BufWritePost,FileWritePost *.gz !gzip <afile>:r
 au FileAppendPre      *.gz !gunzip <afile>
 au FileAppendPre      *.gz !mv <afile>:r <afile>
 au FileAppendPost     *.gz !mv <afile> <afile>:r
 au FileAppendPost     *.gz !gzip <afile>:r
augroup END

" --------------------------------------------------------------------------------
"  Others
" --------------------------------------------------------------------------------
noremap <leader>m :make<CR>

" Reload vimrc
nnoremap <leader>sr :<C-u>source ~/.vimrc<CR>
syntax on
filetype plugin on
filetype indent on

