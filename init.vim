set nocompatible
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
set viminfo+=n~/.config/vim/viminfo
set runtimepath+=~/.config/vim

" Swap files :o
set directory=~/.config/vim/swap//

" Backups :D
set backupdir=~/.config/vim/backup//

" Undo Dir (:
set undodir=~/.config/vim/undo//
set undofile

let g:netrw_home=$XDG_CONFIG_HOME.'/vim'

if empty(glob('~/.config/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'ycm-core/YouCompleteMe'
Plug 'vim-scripts/AutoComplPop'
"Plug 'junegunn/goyo.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'pearofducks/ansible-vim'
call plug#end()

" See: https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" Fuck Ex mode
:map Q <Nop>

" Jump to last known position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Comments
" autocmd CursorMoved * hi Comment ctermbg=1 ctermfg=15
" autocmd CursorMovedI * hi Comment ctermbg=1 ctermfg=15


" Stuff i guess
function! Count( word )
  redir => cnt
    silent exe '%s/' . a:word . '//gn'
  redir END

  let res = strpart(cnt, 0, stridx(cnt, " "))
  return res
endfunction

fu! MaxLen()
    return strlen(max(map(getline(0,"$"), 'matchstr(v:val, "^\\d\\+")')))
endfu

"""" Vim config

filetype plugin indent on

" Powerline
let g:powerline_pycmd="py3"
set laststatus=2   " Always show the statusline
set t_Co=256
let g:Powerline_symbols = 'fancy'

" If you prefer the Omni-Completion tip window to close when a selection
" is made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Syntax highlighting
syntax on

" Wrap lines
set wrap

" F5 toggle passe mode
set pastetoggle=<F5>

" Fuck mouse usage
set mouse=""
"set mouse=a

" Use relative line numbers
set number
set relativenumber

" Use UTF-8 encoding
set encoding=utf-8

" Always show 11 lines above and below cursor
set so=100

" set formatprg=par\ -w78
" map <F4> 2>{v}!par -w78<CR>

" Tabs
"noremap <F1> :tabedit
"noremap <F1> :quitall
"noremap <F2> :Texplore<CR>
"noremap <F3> :tabp<CR>
"noremap <F4> :tabn<CR>
"noremap <F11> :mksession! .session.vim<CR>
"noremap <F12> :source .session.vim<CR>

" Commands
" noremap <F9> :!make<CR><CR>
" inoremap <F9> <ESC>:!make<CR><CR>i

" Tabs should be spaces and 2 characters long
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" set autoindent
set smartindent
set cindent

" Searcing and case sensitiveness
set ignorecase
set smartcase
set incsearch

" No error bells
set noerrorbells

" Delete whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Highlight whitespace with red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Line limits and highlights
let &colorcolumn=join(range(75,999),",") " Default highlight

autocmd bufreadpre *.html setlocal textwidth=74
autocmd bufreadpre *.md setlocal textwidth=74
autocmd bufreadpre *.tex setlocal textwidth=74

" Python
autocmd bufreadpre *.py setlocal textwidth=114
autocmd bufreadpre *.py let &colorcolumn=join(range(115,999),",")

" Latex
autocmd bufreadpre *.tex setlocal textwidth=112
autocmd bufreadpre *.tex let &colorcolumn=join(range(113,999),",")

autocmd bufreadpre *.tex autocmd TextChanged,TextChangedI <buffer> silent write
autocmd bufreadpre *.tex imap ½ <Esc>:w<CR>:!xelatex '%:t'<enter><enter>i
autocmd bufreadpre *.tex nmap ½ <Esc>:w<CR>:!xelatex '%:t'<enter><enter>i
" SaVE on change
" autocmd TextChanged,TextChangedI <buffer> silent write
" inoremap ½ <Esc>:!xelatex '%:t'<enter><enter>i

" Txt
"autocmd bufreadpre *.txt setlocal textwidth=69
"autocmd bufreadpre *.txt let &colorcolumn=join(range(70,999),",")
autocmd bufreadpre *.txt setlocal textwidth=79
autocmd bufreadpre *.txt let &colorcolumn=join(range(81,999),",")
"autocmd bufreadpre *.txt set formatprg=par\ j1w69

autocmd bufreadpre *.dlog setlocal textwidth=79
autocmd bufreadpre *.dlog let &colorcolumn=join(range(80,999),",")

autocmd bufreadpre *.dlog imap <F1> <CR>--<SPACE><C-R>=strftime("%H:%M")<CR><SPACE>--<CR><CR>
autocmd bufreadpre *.dlog nmap <F1> <ESC>i<F1>
autocmd bufreadpre *.dlog imap <F2> <ESC>:r ~/.local/lib/devlog/templates/entry.txt<CR><F8><C-R>=strftime("%Y-%m-%d")<CR><F8><CR><ESC>:exe ":normal i" . Count("Entry #")<CR>:s/^\d\+/\=printf("%0".MaxLen()."d",submatch(0))/<CR><HOME>i<BACKSPACE><BACKSPACE><F8>
autocmd bufreadpre *.dlog nmap <F2> <ESC>i<F2>

autocmd bufreadpre *.dlog imap <F3> <CR>~~~ Snippet Start ~~~<CR><++><CR>~~~ Snippet End   ~~~<CR><++><ESC>4ki
autocmd bufreadpre *.dlog nmap <F3> <ESC>i<F3>

autocmd bufreadpre *.dlog imap <F4> <ESC>o<CR>##><SPACE>
autocmd bufreadpre *.dlog nmap <F4> o<CR>##><SPACE>
autocmd bufreadpre *.dlog set printoptions=formfeed:y,left:2.5in,right:2.5in,top:2.5in,bottom:2.5in,header:0,number:n,wrap:n,duplex:off,paper:A4,formfeed:y

"call matchadd('Search', '\%62l')
"call matchadd('Search', '\%124l')
"call matchadd('Search', '\%186l')
"call matchadd('Search', '\%248l')
"call matchadd('Search', '\%310l')
"call matchadd('Search', '\%372l')
"call matchadd('Search', '\%434l')
"call matchadd('Search', '\%496l')

" Set colors
highlight ColorColumn ctermbg=233 guibg=#2c2d27
hi CursorLine   cterm=NONE ctermbg=237
set cursorline!

" Navigate with guides
inoremap <F7> <Esc>i<Right><++><Right>
vnoremap <F7> <Esc>i<Right><++><Right>
map <F7> <Esc>i<Right><++><Right>
inoremap <F8> <Esc>/<++><Enter>"_c4l
vnoremap <F8> <Esc>/<++><Enter>"_c4l
map <F8> <Esc>/<++><Enter>"_c4l

" Auto compile
" inoremap <F6> <Esc>:!gcc -g '%:t'<enter><enter>i
" vnoremap <F6> <Esc>:!gcc -g '%:t'<enter><enter>v
" map <F6> <Esc>:!gcc -g '%:t'<enter><enter>

" Goyo Extension
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set so=999
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set so=10
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

inoremap <F6> <Esc>:Goyo<CR>i
vnoremap <F6> <Esc>:Goyo<CR>v
map <F6> :Goyo<CR>

function PrintPagination()
    let c = 0
    while c <= line('$')
      let c += 1
      if fmod(c, 62) == 0.0
        call matchadd('Search', '\%'.c.'l')
      endif
    endwhile
endfunction
