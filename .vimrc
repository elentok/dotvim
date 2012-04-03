" vim: foldmethod=marker
" Core {{{1 

set nocompatible " disable vi compatibility
syntax enable
call pathogen#infect()
filetype plugin on
filetype indent on

" Colors {{{1

if has('gui_running')
  color molokai-nobold
else
  " enable 256 colors in the terminal
  set t_Co=256
  color molokai
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi Visual ctermbg=238
endif

" OS Specific {{{1

if has('gui_win32')
  let $temp_dir=$TEMP . '\\vim'
  let $vimrc=$VIMRUNTIME . '/../.vimrc'
  let $vimfiles=$VIMRUNTIME . '/../vimfiles'
  let $session='D:/AppData/session.vim'
  let $delimiter='\\'
  let $defaultfont="Consolas:h12:cANSI"
  let $alternatefont="Courier_New:h12:cHEBREW"
  let g:ruby_path='C:/ruby187'
  set grepprg="findstr /nI"
  let g:Powerline_symbols='compatible'
else
  let $temp_dir='/tmp/vim-' . $USER
  let $vimrc=expand('~/.vimrc')
  let $vimfiles=expand('~/.vim')
  let $session=expand('~/.session.vim')
  let $delimiter = '/'
  let $defaultfont='Monaco\ 10'
  let $alternatefont='Ubuntu\ Mono\ 13'
  let g:Powerline_symbols='fancy'
  " the 'wildignorecase' option is not available for windows
  set wildignorecase
endif

exec "set guifont=" . $defaultfont

if getftype($temp_dir) != 'dir'
  exec 'silent !mkdir ' . $temp_dir
endif

" Settings {{{1
behave mswin
set guioptions=egrLt
set number            " show line numbers
set mouse=a
set scrolloff=3
set iskeyword=@,48-57,_,192-255,$,#,-

set undolevels=1000
set history=300       " remember 300 commands
set visualbell t_vb=

set showmatch                  " briefly jump to matching parenthesis
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set whichwrap=<,>,[,]
set expandtab
set nowrap
set linebreak
set showbreak=>>

" Wild mode:
set wildmenu
set wildmode=full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.obj

" Formatting
set formatoptions=qro
set fillchars="vert:|"
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Rulers
set ruler             " enable ruler
set laststatus=2      " always show the statusline
set titlestring=0\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"not necessary when using the powerline plugin:
"set rulerformat=%40(%3*[B:%n]%1*[L:%03l/%L]%2*[C:%02c]%4*[P:%03p/%P]%6*%m%r%)
"set statusline=%f\ %y\%=[B:%n][L:%03l/%L][C:%02c%V]\ %p/%P

" Search
set incsearch   " incremental search
set ignorecase  " ignore case when search
set smartcase   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch    " highlight search terms

" Highlight Current Line
"set cursorline
"highlight CursorLine guibg=black cterm=none term=none ctermbg=black


" Backup
set backup writebackup
set backupdir=$temp_dir
set dir=$temp_dir

" Folding
set foldtext=getline(v:foldstart)
let php_folding=1
let g:xml_syntax_folding=1

" Ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" Fuzzyfinder tweaks
let g:fuf_file_exclude='\v\~$|\.(o|exe|dll|bak|orig|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|node_modules|tmp'

" Settings: Unicode:{{{1
" With the following settings Vim's UTF-8 behaves as follows:
" - new files with no nonascii chars (>1byte) will be saved as ANSI (no BOM)
" - new files with nonascii chars will be saved as UTF-8 (with BOM)
set encoding=utf-8
" create Unicode files with B.O.M. by default
"setglobal fileencoding=utf-8 bomb
setglobal fileencoding=utf-8
" define the heuristics to recognize file encodings
setglobal fileencodings=ucs-bom,utf-8,default


" Commands {{{1
command! AutoWrap set formatoptions+=c formatoptions+=t
command! AutoWrapOff set formatoptions-=c formatoptions-=t
command! W :w


" Key Mappings {{{1

" Basics
map \\ :nohls<cr>
map \s :set spell!<cr>
map <space> <PageDown>
map - <PageUp>
map <backspace> zc
imap <c-s> <c-o>:w<cr>
" super yank (yank to * and + registers)
vmap \y "*ygv"+y
vmap \r :SubstituteCase@

imap <f2> <c-o>:set rl!<cr>
map <f2> :set rl!<cr>


" File navigation
map ,t :tabe <C-R>=expand("%:p:h") . $delimiter <cr>
map ,e :e <C-R>=expand("%:p:h") . $delimiter <cr>
map ,d :cd <C-R>=expand("%:p:h")<cr><cr>
map ,c :silent !start cmd.exe /k cd /d "<C-R>=expand("%:p:h")<cr>"<cr>
map ,v :tabe $vimrc<cr>
map ,o :FufFile<cr>
map ,, :FufFile **/<cr>
map ,t :FufTag<cr>
map ,R :FufRenewCache<cr>
map ,b :FufBuffer<cr>

map <c-f12> :setlocal foldexpr=MyFoldingExpr(v:lnum)<cr>:setlocal foldmethod=expr<cr>
map <c-s-f12> :setlocal foldmethod=manual<cr>zE
map <c-f11> :vimgrep /^\*/ %<cr>:copen<cr>

map `f :exec "set guifont=" . $defaultfont<cr>
map `F :exec "set guifont=" . $alternatefont<cr>

map <m-space> :simalt ~<cr>
imap <m-space> <c-o>:simalt ~<cr>
map <m-f10> :simalt ~x<cr>
map <m-s-f10> :simalt ~r<cr>

" select a link and press "gx"
vmap gx "xy:call netrw#NetrwBrowseX(@x, 0)<cr>

map \r :!clear; rspec --color --format d spec<cr>

 
" add symbols to the end of the lines:
map `1 :exec ":normal A <c-v><esc>" . (79 - strlen(getline("."))) . "A#"<cr>
map `2 :exec ":normal A <c-v><esc>" . (69 - strlen(getline("."))) . "A="<cr>
map `3 :exec ":normal A <c-v><esc>" . (59 - strlen(getline("."))) . "A-"<cr>
 
" run the selected text:
nmap <c-s-cr> 0v$"xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
vmap <c-cr> "xy:silent exec ":!cmd /c start \"VimCmd\" " . @x<cr>
"nmap <c-cr> :silent exec ":!start cmd /k " . expand("<cword>")<cr>


" Auto Commands {{{1
augroup Elentok_Misc
  autocmd!
  autocmd FileType xml setlocal foldmethod=syntax
  autocmd VimEnter * set t_vb=
  autocmd BufRead,BufEnter *.txt setlocal syntax=dtxt
  autocmd BufRead,BufEnter *.autoSetup setlocal syntax=xml
  autocmd BufRead,BufEnter *.xaml setlocal syntax=xml
  autocmd BufRead,BufEnter *.py setlocal ts=4 softtabstop=4 shiftwidth=4
  autocmd BufRead,BufEnter *.css setlocal foldmethod=marker

  " Javascript
  autocmd BufRead,BufEnter *.js setlocal nocindent smartindent
  autocmd BufRead,BufEnter *.json setlocal filetype=javascript
  autocmd BufRead,BufEnter Brewfile setlocal filetype=coffee

  " Autocomplete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html setlocal autoindent omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType smarty setlocal autoindent

  " UTF8
  autocmd FileType vim setlocal nobomb

  ".vimrc
  autocmd BufWritePost .vimrc source %

  "snippets
  autocmd BufWritePost *.snippets call ReloadAllSnippets()

  " Home file
  autocmd BufRead,BufEnter home.txt map <buffer> <c-cr> :call HomeExecute()<cr>
augroup END


" Extra: JSLint {{{1
func! JSLint()
  if has("win32")
    let jsl = $vimfiles . "/bin/win32/jsl/jsl.exe"
  else
    let jsl = $vimfiles . "/bin/linux/jsl/jsl"
  endif
  cexpr system(jsl . ' -nofilelisting -nocontext -nologo -nosummary -process "' . expand("%:p") . '"')
endfun
map <Leader>j :call JSLint()<cr>

" Extra: CoffeeScript {{{1
"func! CoffeeMake()
  "if expand("%:t") =~ '.js.coffee'
  "else
    "silent make
    "cw
  "end
"endfunc
"augroup Elentok_CoffeeScript
  "autocmd!
  "autocmd BufWritePost *.coffee call CoffeeMake()
"augroup END

" Extra: Folding Expression {{{1
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

" Extra: Home Execute {{{1
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


" Extra: Taglist settings {{{1
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_GainFocus_On_ToggleOpen = 1
map <F3> :TlistToggle<cr>
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map ;; :NERDTreeToggle<cr>

" Misc Notes {{{1
"
" - for some reason 'showcmd' causes a delay after pressing <Escape> in insert
"   mode, so I'm disabling it for now:
"     set showcmd
"
" - to enable autowrap: set formatoptions+=ct
