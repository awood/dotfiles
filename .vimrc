let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  if has('autocmd')
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('autocmd')
    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif
endif

function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
      !./install.py --java-completer
    endif
endfunction

" Updating a plugin
" * Run :PlugUpdate
" * Press D in the window or run :PlugDiff to view differences

" Removing a plugin
" * Delete or comment out Plug commands for the plugins you want to remove.
" * Save and reload vimrc (:source ~/.vimrc) or restart Vim
" * Run :PlugClean. It will detect and remove undeclared plugins.

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-git'
Plug 'tpope/vim-eunuch'

Plug 'preservim/nerdtree'

Plug 'dense-analysis/ale'

Plug 'michaeljsmith/vim-indent-object'

Plug 'terryma/vim-expand-region'

" Create helptags for vim-plug itself
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

Plug 'machakann/vim-highlightedyank'

Plug 'vim-scripts/spec.vim'
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/restore_view.vim'

Plug 'fioncat/vim-yaml-folds'

Plug 'altercation/vim-colors-solarized'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'majutsushi/tagbar'

" tmux syntax highlighting
Plug 'zaiste/tmux.vim'

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }
call plug#end()

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if !PlugLoaded('tpope/vim-sensible')
    set autoindent
    set backspace=indent,eol,start "backspace over everything in insert mode
    set incsearch " do incremental searching
    set wildmenu
    set laststatus=2
    set ruler " show the cursor position all the time
    set history=1000 " keep 1000 lines of command line history
    runtime! macros/matchit.vim
endif

set t_Co=256
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

set backup " keep a backup file

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
set backupdir=~/.vim/backup/ "Set a standard backup directory
set viminfo='20,\"50         " .viminfo file with no more than 50 lines
set showcmd " display incomplete commands
set hlsearch " highlight search results
set showmatch " match parentheses
set ignorecase
set smartcase " ignore case in search strings unless the string has a capital letter
set printoptions=paper:letter "Print in letter size
set spellfile=~/.vim/vimspell.add
set spelllang=en_us
set tags^=./.git/tags;
set wildmode=longest,full "complete the longest string and then each match

set undodir=~/.vim/undo
set undofile
set undolevels=400
set undoreload=400

" restore_view.vim (:mkview under the covers) will remember cursor position,
" code folds, backslash to forward slash conversion, and end-of-line format.
" The 'slash' and 'unix' options are primarily beneficial for Windows
" interoperability.
set viewoptions=cursor,folds,slash,unix

" In many terminal emulators the mouse works just fine, thus enable it. (This
" breaks middle click pasting unless you hold the shift key in insert mode,
" so we'll just use the mouse in normal, visual, and command-line mode.)
if has('mouse')
  set mouse=nvc
endif

syntax enable
colorscheme solarized

" Extend the global default (NOTE: Remove comments in dictionary before sourcing)
" "\/\\n\\n\<CR>": 1, " Motions are supported as well. Here's a search motion that finds a blank line
" 'a]' :1, " Support nesting of 'around' brackets
" 'ab' :1, " Support nesting of 'around' parentheses
" 'aB' :1, " Support nesting of 'around' braces
" 'ii' :0, " 'inside indent'. Available through michaeljsmith/vim-indent-object
" 'ai' :0, " 'around indent'. Available through michaeljsmith/vim-indent-object
call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :1,
      \ 'ai' :1,
      \ })

let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" Default is \ue0a3 which is in a private use area and not available in my
" typeface.  Use Black-Letter C instead
let g:airline_symbols.colnr = "\u212D"

" Set TagBar to sort by order in file instead of by name
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = { 'mail': 1 }

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'

" Put linting errors in the quickfix list rather than the location list. The
" quickfix list is global and seems to be a better fit semantically for
" linting errors
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

" Don't use multiline dictionary format
let g:ale_fixers = {}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.python = ['black']
let g:ale_python_flake8_options = "--ignore='E501,E121,E122,E123,E124,E125,E126,E127,E128'"

let g:NERDTreeChDirMode = 2

" See https://github.com/junegunn/vim-plug/issues/75
let g:plug_timeout = 300

let g:peekaboo_delay = 750

" The default action is to abort the write
let g:DeleteTrailingWhitespace_Action = 'ask'
" But I do still want trailing space highlighted even if I say don't delete it
let g:DeleteTrailingWhitespace_ChoiceAffectsHighlighting = 0

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Mappings
map <F2> :NERDTreeToggle<CR> :wincmd p<CR>
map <F3> :NERDTreeFocus<CR>
map <F8> :TagbarToggle<CR>
map <F12> <Plug>(ale_fix)

" You can use any sort of range with DeleteTrailingWhitespace.
" E.g. :2,10DeleteTrailingWhitespace would delete only the whitespace on line 2 to 10

" The <C-U> in the mapping tells vim that after the : is entered the CTRL-U
" combination should be used to clear the command line, eliminating any
" automatically inserted range
nnoremap <Leader>d$ :<C-u>%DeleteTrailingWhitespace<CR>
vnoremap <Leader>d$ :DeleteTrailingWhitespace<CR>

" Pull up the current file in NERDTree then refocus on the current file pane
map <leader>c :NERDTreeFind<CR> :wincmd p<CR>

" FZF.vim bindings
noremap <leader>b :Buffers<CR>
noremap <leader>m :Marks<CR>
noremap <leader>f :Files<CR>
noremap <leader>gf :GFiles<CR>
noremap <leader>gs :GFiles?<CR>
noremap <leader>hs :History/<CR>
noremap <leader>hc :History:<CR>
noremap <leader>rg :Rg<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" As suggested by the vim docs themselves.  Make Y not just a copy of yy.
" See https://vi.stackexchange.com/questions/6061/ for a discussion of the
" historical reasons behind the redundancy.
map Y y$

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
  autocmd FileType mail,python,ruby,markdown,md,gitcommit setlocal spell

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
  " (happens when dropping a file on gvim) or when in a git commit message
  " since those are transient.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
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
