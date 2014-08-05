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

" Provide a nice status line (if not using vim-powerline)
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%m%r%w                       " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%lL,%cC%V%)             " line, column, virtual-column
set statusline+=%<%p%%                       " file position

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif

if has('gui_running')
  set background=light
else
  set background=dark
endif

set hidden "Allow changing buffers without saving
set tabstop=4
set shiftwidth=4
set expandtab
set backupdir=~/.vim/backup/ "Set a standard backup directory
set viminfo='20,\"50         " .viminfo file with no more than 50 lines
set history=100 " keep 100 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " highlight search results
set showmatch   " match parentheses
set backspace=indent,eol,start "backspace over everything in insert mode
set printoptions=paper:letter  "Print in letter size
set spellfile=~/.vim/vimspell.add
set spelllang=en_us
set wildmenu
set wildmode=longest,full "complete the longest string and then each match

" In many terminal emulators the mouse works just fine, thus enable it. (This
" breaks middle click pasting unless you hold the shift key in insert mode,
" so we'll just use the mouse in normal, visual, and command-line mode.)
if has('mouse')
  set mouse=nvc
endif

" Matching for Ruby
runtime! macros/matchit.vim

" Start pathogen and write helptags
runtime bundle/vim-pathogen/autoload/pathogen.vim
" YouCompleteMe only works on 7.3.584 and higher
if v:version < 703 || v:version == 703 && !has("patch584")
  let g:pathogen_disabled = ["YouCompleteMe"]
endif
execute pathogen#infect()
call pathogen#helptags()

syntax enable
colorscheme solarized
call togglebg#map("<F5>")

let g:Powerline_symbols = 'unicode'

" Set TagBar to sort by order in file instead of by name
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = { 'mail': 1 }

" Set up syntastic
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_java_javac_custom_classpath_command = "buildr -s syntastic:echo"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore='E501,E121,E122,E123,E124,E125,E126,E127,E128'"

let g:syntastic_ruby_checkers = ['mri']

" Mappings
map <F2> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
map <Leader>b :MiniBufExplorer<CR>
map <Leader>t :TMiniBufExplorer<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

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

" Change working directory to directory of current file
if !exists(":CDC")
  command CDC cd %:p:h
endif

if &term =~ '^screen'
  " tmux will send xterm-style keys when its xterm-keys option is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
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
  " Clear vimrcEx group in case we are sourced twice
  autocmd!
  autocmd FileType mail,python,ruby,markdown,gitcommit setlocal spell

  " treat four spaces together as a single character with backspacing
  autocmd FileType python set softtabstop=4

  " highlight end of line whitespace
  highlight WhitespaceEOL ctermbg=red guibg=red
  autocmd FileType python,ruby match WhitespaceEOL /\s\+$/

  " Don't expand tabs for makefiles
  autocmd FileType make setlocal noexpandtab

  " Turn off balloons in ruby.  See http://stackoverflow.com/a/1111363
  if has("gui_running")
    autocmd FileType ruby,eruby set noballooneval
  endif

  " Indent two spaces for these types
  autocmd FileType ruby,eruby,yaml,html,less,vim,xml,ant set ai sw=2 sts=2 et

  " Turn off the visual bell in both gui and terminal mode
  autocmd VimEnter * set vb t_vb= 

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
  " always set autoindenting on
  set autoindent
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif
