" Copyed from $VIMRUNTIME/vimrc_example.vim
" and customized by jiongyao.zhu
"
" Maintainer:	Zhu Jiongyao <zhujiongyao@gmail.com>

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Add by jiongyao.zhu
set history=5000  " keep 5000 lines of command line history
" 背景色
set background=light
" colorcolumn
highlight ColorColumn ctermbg=0 guibg=lightgrey
set colorcolumn=80,101
" 显示行号
set number
" Tab的长度设置为4
" 一个Tab键所占的列数
set tabstop=4
" 敲入Tab键时实际占有的列数
set softtabstop=4
" reindent 操作(<<和>>)时缩进的列数
set shiftwidth=4
" Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" strip all trailing whitespace in the current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" make
autocmd FileType python setlocal makeprg=python\ %  " .py
" 设置yaml缩进为2个空格
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" 设置json缩进为2个空格
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" undodir
set undodir=/var/tmp/
" swap file directory
set directory=/var/tmp//
" backupdir
set backupdir=/var/tmp/
autocmd BufWritePre * let &backupext ='@'.substitute(substitute(substitute(expand('%:p:h'), '/', '%', 'g'), '\', '%', 'g'),  ':', '', 'g').'~'

" NERDTree
" open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1
" map a specific key or shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" NERDTree 中忽略 .pyc 文件
let NERDTreeIgnore = ['\.pyc$']

" completor
" Python - Use jedi for completion
let g:completor_python_binary = '~/zjy_venvs/jedi_venv/bin/python'
" Use Tab to select completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" <C-b> Goto definitions
" noremap <C-b> :call completor#do('definition')<CR>
noremap <C-b> :vsplit \| call completor#do('definition')<CR>
" <S-k> Show Documentation
noremap <S-k> :call completor#do('doc')<CR>
" ,s get the call signature
noremap ,s :call completor#do('signature')<CR>

" python-syntax
let g:python_highlight_all = 1

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc  " macOS/Linux
let g:ctrlp_max_height = 15
let g:ctrlp_max_files = 20000

" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" ale
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
" :ALEFix will try and fix your Python code with autopep8 and yapf.
let g:ale_fixers = {
\   'python': ['yapf'],
\}
" Fix files automatically on save. This is off by default.
" let g:ale_fix_on_save = 1
" The format for echo messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
" Navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Run linters only when I save files
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" ctrlsf
let g:ctrlsf_ackprg = '/usr/local/bin/rg'  " 让ctrlsf使用ripgrep(rg)做搜索
" 一些快捷键映射
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" CtrlSF locates project root by searching VCS root (.git, .hg, .svn, etc.)
let g:ctrlsf_default_root = 'project'

" indentLine
let g:indentLine_char='┆'
let g:indentLine_color_term = 239
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 0

" vim-markdown
let g:vim_markdown_folding_disabled = 0
autocmd BufNewFile,BufRead *.md set nofoldenable  " 打开.md文件的时候默认不折叠
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_fenced_languages = ['python=python']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1


" Generating Vim help files for packages
" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
