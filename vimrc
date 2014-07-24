runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
Helptags

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set vb t_vb=

set encoding=utf-8

syntax enable
if has('gui_running')
    colorscheme lucius
    LuciusDarkLowContrast
    au VimEnter * NERDTree
    au VimEnter * wincmd p
else
    set t_Co=256
    colorscheme lucius
    LuciusDarkLowContrast
endif
au VimEnter * MBEOpen
au VimEnter * set splitbelow
au VimEnter * set splitright
au BufRead * :YAIFAMagic

set lcs=eol:↲,tab:>-,trail:·
set list

filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set foldmethod=syntax
set guifont=Inconsolata\ Medium\ 10

set number
set tabstop=4
set shiftwidth=4
set expandtab
set foldnestmax=3

inoremap jk <esc>
inoremap <Home> <esc>^i
nnoremap <Home> ^
inoremap <Home><Home> <esc> 0i
nnoremap <Home><Home> 0
nnoremap '# :let @/ = ""<CR>
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-Down> :m .1<CR>
nnoremap <space> za
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"add/remove spaces between brackets
nnoremap <C-S-O> [(ldw])beldw
nnoremap <C-S-I> [(a <Esc>])i <Esc>

command Q :q
command Qa :qa
command QA :qa
command W :w
command Wq :wq
command WQ :wq
command WQA :wqa
command Wqa :wqa
command WQa :wqa

if has("win32")
    runtime vimrc_win
else
    runtime vimrc_linux
endif

"match columns > 120
au BufWinEnter * let w:mlength = matchadd('Error', '\%121v.\+', -2)
"match trailing whitespace and spaces before tabs
au BufWinEnter * let w:mtrailing = matchadd('Error', '\s\+$\| \+\ze\t , -2')

"Ignores
set wildignore+=*.swp,*.class,*.o,*~
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'

command! -nargs=1 SD call CtrlPSpecificDirectory( <f-args> )
command! -nargs=1 Sd call CtrlPSpecificDirectory( <f-args> )

function! CtrlPSpecificDirectory( directory )
    let l:default = 'ra'
    if exists( "g:ctrlp_working_path_mode" )
        let l:default = g:ctrlp_working_path_mode
    endif
    let g:ctrlp_working_path_mode = 0
    exe 'cd' a:directory
    echo a:directory
    CtrlP
    let g:ctrlp_working_path_mode = l:default
endfunction


"[PYTHON]"

"Setup basic python stuff
function! ConfigureForPython()
    nnoremap <F5> :w<CR> :RPy<CR>
    command! -nargs=* R RPy <args>
    set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    set foldmethod=indent
    set omnifunc=pythoncomplete#Complete
endfunction

"lucius
let python_highlight_all=1
let python_version_2 = 1
let g:xml_syntax_folding=1

au FileType python call ConfigureForPython()
"au BufWritePre * :%s/\s\+$//e "strip spaces

"[JAVA]

function! ConfigureJava()
    set autoindent
    set smartindent
endfunction

au FileType java call ConfigureJava()

"[OPENCL]"

function! ConfigureForOpenCl()
    set ft=opencl
endfunction

au BufNewFile,BufRead *.cl call ConfigureForOpenCl()

"[GIT]

au FileType gitcommit au! BufEnter call setpos('.', [0, 1, 1, 0])

if filereadable( $HOME . "/.vim/vimrc_specific" )
    runtime vimrc_specific
endif
