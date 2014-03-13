" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set t_Co=256
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'unicode'

"Provide a nice status line (mine)
"(If not using vim-powerline)
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%m%r%w                       " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%lL,%cC%V%)             " line, column, virtual-column
set statusline+=%<%p%%                       " file position

"Allow changing buffers without saving
set hidden

"Substitute 4 spaces for tabs (mine)
set tabstop=4
set shiftwidth=4
set expandtab

"Start pathogen and write helptags (mine)
runtime bundle/vim-pathogen/autoload/pathogen.vim
"YouCompleteMe only works on 7.3.584 and higher
if v:version < 703 || v:version == 703 && !has("patch584")
    let g:pathogen_disabled = ["YouCompleteMe"]
endif
execute pathogen#infect()
call pathogen#helptags()

"Set wildmenu
set wildmenu
"Set wildmode to complete the longest string and then each match
set wildmode=longest,full

"Set TagBar to sort by order in file instead of by name (mine)
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = { 'mail': 1 }

"Set up syntastic (mine)
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore='E501,E121,E122,E123,E124,E125,E126,E127,E128'"

"Spell-check in mutt (mine)
set spellfile=~/vimspell.add
autocmd FileType mail setlocal spell

"in Python, treat four spaces together as a single character with backspacing
"(mine)
autocmd FileType python set softtabstop=4

let python_highlight_all = 1
" Auto completion via ctrl-space (instead of the nasty ctrl-x ctrl-o)
set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

"highlight end of line whitespace (mine)
highlight WhitespaceEOL ctermbg=red guibg=red
autocmd FileType python,ruby match WhitespaceEOL /\s\+$/

autocmd FileType ruby,eruby,yaml,html,less set ai sw=2 sts=2 et
runtime! macros/matchit.vim

"Don't expand tabs for makefiles (mine)
au FileType make setlocal noexpandtab

"Set a standard backup directory (mine)
set backupdir=~/.vim/backup/

"Print in letter size (mine)
set printoptions=paper:letter 

"Add some useful mappings (mine)
map <F2> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
map <Leader>b :MiniBufExplorer<CR>
map <Leader>t :TMiniBufExplorer<CR>

" Swap definitions for :tag and :tjump. :tag just goes to the first match,
" while :tjump goes to the first match unless there are multiple matches in
" which case it shows a select list.
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>
vnoremap g<C-]> <C-]>

" Opposite of 'J': split a line.  (By default 'K' runs man on the word under
" the cursor.)
nnoremap K i<CR><Esc>

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Turn off the visual bell in both gui and terminal mode (mine)
autocmd VimEnter * set vb t_vb= 

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set viminfo='20,\"50    " read/write a .viminfo file with no more than 50 lines of registers
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set showmatch		" match parentheses

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it. (This
" breaks middle click pasting unless you hold the shift key in insert mode,
" so we'll just use the mouse in normal, visual, and command-line mode.)
if has('mouse')
  set mouse=nvc
endif

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif
