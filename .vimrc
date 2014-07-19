runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

if has('gui_running')
    colorscheme lucius
    LuciusDarkLowContrast
    au VimEnter * NERDTree
    au VimEnter * wincmd p
else
    colorscheme ron
endif
au VimEnter * MBEOpen
au VimEnter * set splitbelow 
au VimEnter * set splitright

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set foldmethod=syntax
set guifont=Inconsolata\ Medium\ 10

set number
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=manual
syntax on

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

command Q :q
command Qa :qa
command QA :qa
command W :w
command Wq :wq
command WQ :wq
command WQA :wqa
command Wqa :wqa
command WQa :wqa

"[PYTHON]"

"Run Python scripts from gvim

let s:python_26 = 26
let s:python_27 = 27
let s:python_3 = 3

command! -nargs=* RPy silent !gnome-terminal -e "bash -c 'cd %:p:h; python %:p <args>; read'" <CR>

command! Py26 call SetPythonVersion( s:python_26 )
command! Py27 call SetPythonVersion( s:python_27 )
command! Py3 call SetPythonVersion( s:python_3 ) 

function! SetPythonVersion( pVersion )
    if a:pVersion == s:python_26
        command! -nargs=* RPy silent !gnome-terminal -e "bash -c 'cd %:p:h; module load python/2.6.6; python %:p <args>; read'" <CR>
        Python2Syntax
        echo "Set to Python 2.6"
    elseif a:pVersion == s:python_27
        command! -nargs=* RPy silent !gnome-terminal -e "bash -c 'cd %:p:h; module load python/2.7; python %:p <args>; read'" <CR>
        Python2Syntax
        echo "Set to Python 2.7"
    elseif a:pVersion == s:python_3
        command! -nargs=* RPy silent !gnome-terminal -e "bash -c 'cd %:p:h; module load python/3.2.2; python %:p <args>; read'" <CR>
        Python3Syntax
        echo "Set to Python 3.2"
    else
        command! -nargs=* RPy silent !gnome-terminal -e "bash -c 'cd %:p:h; python %:p <args>; read'" <CR>
        echo "Unknown parameter - Set to default Python version"
    endif
endfunction

command! -nargs=* TPy !echo "bash -c 'cd %:p:h; python %:p <args>; read'"

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
au BufWritePre *.py :%s/\s\+$//e "strip spaces

"[GIT]

au FileType gitcommit au! BufEnter call setpos('.', [0, 1, 1, 0])


