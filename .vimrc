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

" Provide a nice status line (if not using vim-airline)
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

set modeline "Respect others modelines
set hidden "Allow changing buffers without saving
set linebreak "Break lines on whitespace only
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backupdir=~/.vim/backup/ "Set a standard backup directory
set viminfo='20,\"50         " .viminfo file with no more than 50 lines
set history=100 " keep 100 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " highlight search results
set showmatch   " match parentheses
set ignorecase
set smartcase   " ignore case in search strings unless the string has a capital letter
set backspace=indent,eol,start "backspace over everything in insert mode
set printoptions=paper:letter  "Print in letter size
set spellfile=~/.vim/vimspell.add
set spelllang=en_us
set tags^=./.git/tags;
set wildmenu
set wildmode=longest,full "complete the longest string and then each match

set undodir=~/.vim/undo
set undofile
set undolevels=400
set undoreload=400

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

let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_powerline_fonts = 1

" Set TagBar to sort by order in file instead of by name
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = { 'mail': 1 }

" Set up syntastic
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['java'] }
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_balloons = 1

let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_java_javac_custom_classpath_command = "buildr -s syntastic:echo"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore='E501,E121,E122,E123,E124,E125,E126,E127,E128'"

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:syntastic_javascript_checkers = ['jshint']

let g:unite_source_history_yank_enable = 1

let g:NERDTreeChDirMode = 2

" Mappings
map <F2> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
map <Leader>b :MBEOpen<CR>
map <Leader>t :MBEToggle<CR>

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

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#profile('default', 'context', {
\  'start_insert': 1,
\  'winheight': 5,
\  'direction': 'botright',
\ })

call unite#custom#source('file_rec/async,file_mru,file,grep',
\ 'ignore_pattern', '\.git\|\.class\|\.pyc\|\.pyo'
\ )

" Use \f to find stuff
map <leader>f :<C-u>Unite -buffer-name=files file_rec/async:!<CR>
" Use \y to search yank history
map <leader>y :<C-u>Unite -buffer-name=yank history/yank<CR>
" Use \l to emulate :ls
map <leader>l :<C-u>Unite -buffer-name=buffers buffer<CR>
" Use \r to show registers
map <leader>r :<C-u>Unite -buffer-name=registers register<CR>

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

  " highlight end of line whitespace
  highlight ShowTrailingWhiteSpace ctermbg=red guibg=red

  " Don't expand tabs for makefiles
  autocmd FileType make setlocal noexpandtab

  " Turn off balloons in ruby.  See http://stackoverflow.com/a/1111363
  if has("gui_running")
    autocmd FileType ruby,eruby setlocal noballooneval
  endif

  " Indent two spaces for these types
  autocmd FileType ruby,eruby,yaml,html,less,vim,xml,ant,scss setlocal ai sw=2 sts=2 et
  " Something about RVM and rubycomplete together results in error
  " messages printed to the console about gems missing native extensions
  autocmd FileType ruby setlocal omnifunc=syntaxcomplete#Complete

  " Turn off the visual bell in both gui and terminal mode
  autocmd VimEnter * set vb t_vb= 

  " For all text files wrap at 80 characters and show right margin
  autocmd FileType text,markdown setlocal textwidth=80 colorcolumn=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                 \ | wincmd p | diffthis
endif
