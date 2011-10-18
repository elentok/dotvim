syntax enable
"color koehler
"color wombat
color molokai

set nocompatible

call pathogen#infect()
filetype plugin on
filetype indent on

if has('gui_win32')
  let $temp='t:/vim'
  let $vimrc=$VIMRUNTIME . '/../.vimrc'
  let $vimfiles=$VIMRUNTIME . '/../vimfiles'
  let $session='D:/AppData/session.vim'
  let $delimiter = '\\'
  set guifont=Consolas:h12:cANSI
  let g:ruby_path='C:/ruby187'
  "set guifont=Monaco:h10:cANSI
else
  let $temp='/tmp/vim-' . $USER
  let $vimrc=expand('~/.vimrc')
  let $vimfiles=expand('~/.vim')
  let $session=expand('~/.session.vim')
  let $delimiter = '/'
  "set guifont=Consolas\ 10
  "set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
  set guifont=Ubuntu\ Mono\ 14
endif

map `f :set guifont=Consolas:h12<cr>
map `F :set guifont=Courier_New:h12:cHEBREW<cr>

if getftype($temp) != 'dir'
  exec '!mkdir ' . $temp
endif

" if getftype($session) != 'file'
"   mksession! $session 
" endif



" misc
set number
set wildmenu wildmode=full
set grepprg="findstr /nI"
set showcmd undolevels=1000 history=300
set incsearch ignorecase hlsearch
set backspace=2 whichwrap=<,>,[,] expandtab
set nowrap linebreak showbreak=>>
set formatoptions=qro
"to enable autowrap: set formatoptions+=ct
set fillchars="vert:|"
set vb t_vb=
set ruler laststatus=2 " enable ruler + always show the statusline
set rulerformat=%40(%3*[B:%n]%1*[L:%03l/%L]%2*[C:%02c]%4*[P:%03p/%P]%6*%m%r%)
set statusline=%f\%=[B:%n][L:%03l/%L][C:%02c%V]\ %p/%P
set ts=2 softtabstop=2 shiftwidth=2
set titlestring=0\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set t_vb=

" backup
set backup writebackup
set backupdir=$temp
set dir=$temp

" commands
command! AutoWrap set formatoptions+=c formatoptions+=t
command! AutoWrapOff set formatoptions-=c formatoptions-=t
command! W :w

map ,t :tabe <C-R>=expand("%:p:h") . $delimiter <cr>
map ,e :e <C-R>=expand("%:p:h") . $delimiter <cr>
map ,d :cd <C-R>=expand("%:p:h")<cr><cr>
map ,c :silent !start cmd.exe /k cd /d "<C-R>=expand("%:p:h")<cr>"<cr>

map <Leader>c :TagbarOpen<cr>
map <Leader>d :E d:<cr>
map <Leader>v :tabe $vimrc<cr>
map <Leader>h :tabe d:/documents/home.txt<cr>
map <Leader>t :NERDTreeToggle<cr>
map <Leader>s :set spell!<cr>

map <Leader>o :FufFile<cr>
map <Leader>f :FufFile **/<cr>
map <Leader>F :FufRenewCache<cr>
map <Leader>b :FufBuffer<cr>

" JSLint ==================================
func! JSLint()
  if has("win32")
    let jsl = $vimfiles . "/bin/win32/jsl/jsl.exe"
  else
    let jsl = $vimfiles . "/bin/linux/jsl/jsl"
  endif
  cexpr system(jsl . ' -nofilelisting -nocontext -nologo -nosummary -process "' . expand("%:p") . '"')
endfun

map <Leader>j :call JSLint()<cr>

map <space> <PageDown>
map - <PageUp>
map <backspace> zc

imap <c-s> <c-o>:w<cr>
imap <c-space> <c-x><c-n>

"autocmd VimLeave * mksession! $session
"autocmd VimEnter * so $session
autocmd VimEnter * set t_vb=

set foldtext=getline(v:foldstart)
let php_folding=1
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax


autocmd BufRead,BufEnter *.txt setlocal syntax=dtxt
autocmd BufRead,BufEnter *.autoSetup setlocal syntax=xml
autocmd BufRead,BufEnter *.xaml setlocal syntax=xml
autocmd BufRead,BufEnter *.json setlocal syntax=javascript
autocmd BufRead,BufEnter *.py setlocal ts=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufEnter *.css setlocal foldmethod=marker

map <c-f12> :setlocal foldexpr=MyFoldingExpr(v:lnum)<cr>:setlocal foldmethod=expr<cr>
map <c-s-f12> :setlocal foldmethod=manual<cr>zE
map <c-f11> :vimgrep /^\*/ %<cr>:copen<cr>

imap <f12> <c-r>=strftime("%d/%m/%Y %H:%M")<cr>
imap <c-d> <c-r>=strftime("%Y-%m-%d %H:%M")<cr>


function! MyFoldingExpr(lnum)
    let line=getline(a:lnum)
    if line[0] == '*'
        if line[1] == '*'
            return '>2'
        else
            return '>1'
        endif
    else
        return '='
    endif
endfunction

map ,, :nohls<cr>
"set guioptions=egmrLtT
"set guioptions=egmrLt
set guioptions=egmrLt

behave mswin

map <m-space> :simalt ~<cr>
imap <m-space> <c-o>:simalt ~<cr>
map <m-f10> :simalt ~x<cr>
map <m-s-f10> :simalt ~r<cr>

"*open link ==========================================================
" select a link and press "gx"
vmap gx "xy:call netrw#NetrwBrowseX(@x, 0)<cr>
 
"*add symbols to the end of the lines ================================
map `1 :exec ":normal A <c-v><esc>" . (79 - strlen(getline("."))) . "A#"<cr>
map `2 :exec ":normal A <c-v><esc>" . (69 - strlen(getline("."))) . "A="<cr>
map `3 :exec ":normal A <c-v><esc>" . (59 - strlen(getline("."))) . "A-"<cr>
 
"*run the selected text ==============================================
nmap <c-s-cr> 0v$"xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
vmap <c-cr> "xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
"nmap <c-cr> :silent exec ":!start cmd /k " . expand("<cword>")<cr>

" Unicode Settings #############################################################
" With the following settings Vim's UTF-8 behaves as follows:
" - new files with no nonascii chars (>1byte) will be saved as ANSI (no BOM)
" - new files with nonascii chars will be saved as UTF-8 (with BOM)
set encoding=utf-8
" create Unicode files with B.O.M. by default
"setglobal fileencoding=utf-8 bomb
setglobal fileencoding=utf-8
" define the heuristics to recognize file encodings
setglobal fileencodings=ucs-bom,utf-8,default

function! ShowSidebars()
  copen
  TagbarOpen
  NERDTree
  wincmd l
endfunction

function! HideSidebars()
  cclose
  TagbarClose
  NERDTreeClose
endfunction

map <f11> :call HideSidebars()<cr>
map <f12> :call ShowSidebars()<cr>


augroup David
  " Javascript
  autocmd!
  autocmd BufRead,BufEnter *.js setlocal nocindent smartindent

  " Autocomplete
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS

  " UTF8
  autocmd FileType vim setlocal nobomb

  ".vimrc
  autocmd BufWritePost .vimrc source %

  "snippets
  autocmd BufWritePost *.snippets call ReloadAllSnippets()

augroup END

" Highlight Current Line
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

highlight CursorLine guibg=black

func! HomeExecute()
  let line = getline('.')
  let line = substitute(line, '^ \+', '', '')
  let line = substitute(line, ' \+$', '', '')
  if isdirectory(line)
    execute 'cd ' . line
    execute 'e ' . line
  elseif filereadable(line)
    execute 'e ' . line
  endif
endfunc

augroup David_Home
  autocmd!
  " Home file
  autocmd BufRead,BufEnter home.txt map <buffer> <c-cr> :call HomeExecute()<cr>
augroup END


