set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set ignorecase
set smartcase
set cursorline
set gdefault

set foldenable
set foldmethod=manual

if has('persistent_undo')
	if !isdirectory("$HOME~/.vim/undo")
        silent execute '!mkdir -p ~/.vim/undo'
    endif
	set undofile
    set undodir=$HOME/.vim/undo
    set undolevels=1000
    set undoreload=9001
endif

if has("autocmd")
	augroup resCur
		" When editing a file, always jump to the last cursor position
		autocmd BufReadPost *
		\ if line("'\"") > 0 && line ("'\"") <= line("$") |
		\   exe "normal! g'\"" |
		\ endif
	augroup END

	" remove trailing spaces on saving
	autocmd BufWritePre * :%s/\s\+$//e
endif

" TODO: what means following setting?
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1

let mapleader = "\<Space>"

:nnoremap <Tab> :bnext<CR>:redraw<CR>:ls<CR>
:nnoremap <S-Tab> :bprevious<CR>:redraw<CR>:ls<CR>
:nmap j gj
:nmap k gk
:nmap <S-i> i_<Esc>r
:nmap <S-C> <Plug>CommentaryLine
:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>
inoremap jj <ESC>l
inoremap оо <ESC>l

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" auto replace this string with current date
:iab <expr> 0--- strftime("# %c")

au BufRead,BufNewFile *.applescript	set filetype=applescript
au FileType html set tabstop=8|set shiftwidth=2|set expandtab

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-sensible'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-expand-region'
" Plugin 'vim-scripts/YankRing.vim'
" Plugin 'c9s/gsession.vim'
" Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-surround'
" Plugin 'svermeulen/vim-easyclip'
Plugin 'tpope/vim-repeat'
" Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'rodjek/vim-puppet'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'henrik/vim-indexed-search'
Plugin 'powerman/vim-plugin-autosess'
call vundle#end()
filetype plugin indent on
map <Leader> <Plug>(easymotion-prefix)
map <Leader>jv :%!python -m json.tool<CR>
map <Leader>jc :%ruby -c<CR>

" source: http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
" {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" vnoremap <silent> p "0p`]
" nnoremap <silent> p "0p`]
" vnoremap <silent> P "0P`]
" nnoremap <silent> P "0P`]

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

noremap gV `[v`]

let g:airline_theme='powerlineish'
" }}}

set background=dark
colorscheme solarized

autocmd BufWritePost *.coffee silent make!
autocmd filetype crontab setlocal nobackup nowritebackup

let g:Lf_WildIgnore = {
    \ 'dir': ['localpy', '.svn', '.git'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \}

let vimpager_passthrough = 1

augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

set modelines=5

let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

set timeoutlen=500
set clipboard=unnamed

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>n <Plug>yankstack_substitute_newer_paste
map <leader>s <Plug>(expand_region_shrink)

" call expand_region#custom_text_objects({
"       \ "\/\\n\\n\<CR>": 1,
"       \ 'a]' :1,
"       \ 'ab' :1,
"       \ 'aB' :1,
"       \ 'ii' :0,
"       \ 'ai' :0,
"       \ })

au FileType puppet setl sw=4 sts=4 et
au FileType yaml setl sw=2 sts=2 et
autocmd FileType yaml setl indentkeys-=<:>
autocmd FileType nginx setlocal commentstring=#%s
autocmd FileType puppet setlocal commentstring=#%s
setlocal commentstring=#%s

set hidden