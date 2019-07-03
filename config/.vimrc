" .vimrc
" Esteban de la Torre

"------------------------------------------------------------------------------
" Features
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
"------------------------------------------------------------------------------

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on

"------------------------------------------------------------------------------
" Must have options
"
" These are highly recommended options.
"------------------------------------------------------------------------------

" Better command-line completion
set wildmenu

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

"------------------------------------------------------------------------------
" Usability options
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
"------------------------------------------------------------------------------

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
" set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Highlight current line (slow in ConEmu)
" set cursorline

" highlight matching [{()}]
set showmatch

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F12>

" Set universal eol file formats
set ffs=unix,dos,mac

"------------------------------------------------------------------------------
" Indentation options
"
" Indentation settings according to personal preference.
"------------------------------------------------------------------------------

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab


"------------------------------------------------------------------------------
" Mappings
"
" Useful mappings
"------------------------------------------------------------------------------

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Toggle search highlighting until the
noremap fj :set hlsearch!<CR>
noremap fh :set incsearch!<CR>

" Map escape to jj
inoremap jj <esc>

" Easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Go to File
noremap gf <C-w>f

" Grep next/previous
noremap <silent> <C-n> :cn<CR>zv
noremap <silent> <C-p> :cn<CR>zv

" Set root path for find command
set path+=**

" Set default split directions
set splitbelow
set splitright

" Show previous command
set laststatus=2

" Copy file path
"nmap ccc :!"echo % | pbcopy"<CR>

"------------------------------------------------------------------------------
" Functions
"
" Useful functions
"------------------------------------------------------------------------------

" toggle between number and relativenumber (relativenumber slow in ConEmu)
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" Call toggle number function
nnoremap & :call ToggleNumber()<CR>

" set color when in normal, replace, or insert mode
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=magenta ctermfg=magenta
	set statusline=INSERT\|\ \ %F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
  elseif a:mode == 'r'
    hi statusline guibg=yellow ctermfg=yellow
	set statusline=REPLACE\|\ \ %F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
  elseif a:mode == 'v'
	hi statusline guibg=blue ctermfg=blue
	set statusline=VISUAL\|\ \ %F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
  elseif a:mode == 'n'
	hi statusline guibg=cyan ctermfg=cyan
	set statusline=NORMAL\|\ \ %F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
  else
	hi statusline guibg=red ctermfg=red
	set statusline=UNKNOWN\|\ \ %F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * call InsertStatuslineColor('n')
au BufEnter * call InsertStatuslineColor('n')

" refresh buffer if changes are detected
set autoread
au CursorMoved * checktime
au CursorMovedI * checktime
au FileChangedShell * checktime
