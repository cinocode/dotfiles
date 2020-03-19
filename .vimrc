if has("unix")
	if filereadable(fnamemodify(expand("~"), ':p') . '/.local.vim')
		so ~/.local.vim
	endif

	set backupdir=~/.vim/backup/
	set directory=~/.vim/backup/
else
	if filereadable(fnamemodify(expand("~"), ':p') . '/.local.vim')
		so ~\.local.vim
	endif

	set backupdir=~\vimfiles\backup\
	set directory=~\vimfiles\backup\
	autocmd GUIEnter * cd ~

endif

set encoding=utf-8
setglobal fileencoding=utf-8
autocmd! bufwritepost .vimrc source %
set diffexpr=

set laststatus=2
set nu
set rnu
set hls
set splitbelow
set splitright
set foldmethod=marker
set nocompatible
filetype plugin on
filetype plugin indent on
set hidden
set bs=2
set timeoutlen=1200	" A little bit more time for macros
set ttimeoutlen=50	" Make Esc work faster

syntax on
set autoindent
set sts=0
set tabstop=4
set shiftwidth=4
set expandtab

if has("autocmd")
	autocmd FileType java setlocal ts=4 sts=0 sw=4 expandtab
	autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType cs setlocal ts=4 sts=4 sw=4 expandtab
	autocmd FileType vb setlocal ts=3 sts=3 sw=3 expandtab
	autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab
endif

let linez=40
let columnz=120
autocmd GUIEnter * let &lines=linez | let &columns=columnz
autocmd GUIEnter * if has("diff") && &diff | set lines=60 columns=200 | endif
if has("gui_running")
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar

	colorscheme blayden
	hi link CtrlSpaceStatus IncSearch

	if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		set guifont=Consolas:h11:cANSI
	endif
elseif has("win32")
else
	set background=dark
	colorscheme base16-default-dark
	hi Normal ctermbg=none
endif

let macvim_skip_colorscheme=1
let macvim_skip_cmd_opt_movement=1
let macvim_hig_shift_movement=1

highlight DoubleWhite ctermbg=240 guibg=#333333
call matchadd('DoubleWhite', ' \{2,\}')
highlight ColorColumn ctermbg=darkgreen
call matchadd('ColorColumn', '\%121v', 120)
set list
set listchars=nbsp:¡,eol:¬,tab:»\ ,extends:>,precedes:<,trail:·
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

let g:ctrlspace_use_tabline = 1
let g:ctrlp_show_hidden = 1
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
let g:ctrlp_custom_ignore = '\v[\/](\.git|gradle|node_modules|bower_components|public|build)$'
let g:fortune_vimtips_auto_display = 0

map <F2> :set nohls<CR>:let @/ = ""<CR>:set hls<CR>
"nnoremap / /\v
"cnoremap %s// %s//
"cnoremap %s/ %s/\v
"cnoremap s// :s//
"cnoremap s/ :s/\v
"vnoremap :s// :s//
"vnoremap :s/ :s/\v
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'
let mapleader = ","
nnore \ ,
"these block my \ function as ,
if mapcheck("\c")
	nunmap \c
endif
if mapcheck("\p")
	nunmap \p
endif
if mapcheck("\n")
	nunmap \n
endif
if has("browse")
	nnoremap <c-s> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR><CR>
else
	nnoremap <c-s> :w<cr>
endif
inoremap <c-s> <esc>:w<cr>
"nnoremap <c-n> :wall<cr>
"inoremap <c-n> <esc>:wall<cr>
nnoremap <c-w>o <c-w>o:e<cr>
"nnoremap <c--> :qa<cr>
"nnoremap <c-_> :qa<cr>
"nnoremap <c-/> :qa<cr>
"nnoremap <c-?> :qa<cr>
nnoremap <c-z> :qa<cr>
nnoremap <silent> <c-w>z :wincmd z<bar>cclose<bar>lclose<cr>:DBResultsClose<cr>

nnoremap Y y$
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <silent> dsf :call <SID>DeleteSurroundingFunctionCall()<cr>
nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

nnoremap <silent> [ü :cprevious<cr>
nnoremap <silent> ]ü :cnext<cr>
nnoremap <silent> [Ü :cfirst<cr>
nnoremap <silent> ]Ü :clast<cr>
nnoremap <silent> [C gg]c[c
nnoremap <silent> ]C G[c]c
nnoremap <silent> <leader>ac mmgg"*yG`m
vnoremap <silent> <leader>ac "*y
nnoremap <silent> <leader>lf :LocateFile<cr>

nnoremap <silent> <leader>jb :Buffers<cr>
nnoremap <silent> <leader>jc :JavaSearchContext<cr>
nnoremap <silent> <leader>jf :%JavaFormat<cr>
nnoremap <silent> <leader>jh :JavaCorrect<cr>
nnoremap <silent> <leader>ji :JavaImportOrganize<cr>
nnoremap <silent> <leader>jj :w<cr>:JavaImportOrganize<cr>:%JavaFormat<cr>:Validate<cr>:e<cr>
nnoremap <silent> <leader>jgb :JavaGetSet<cr>
vnoremap <silent> <leader>jgb :JavaGetSet<cr>
nnoremap <silent> <leader>jgc :JavaConstructor<cr>
vnoremap <silent> <leader>jgc :JavaConstructor<cr>
nnoremap <silent> <leader>jgg :JavaGet<cr>
vnoremap <silent> <leader>jgg :JavaGet<cr>
nnoremap <silent> <leader>jgs :JavaSet<cr>
vnoremap <silent> <leader>jgs :JavaSet<cr>
nnoremap <silent> <leader>jm :JavaHierarchy<cr>
nnoremap <silent> <leader>jr :exec ":JavaRename ".input("Rename to:")<cr>
nnoremap <silent> <leader>js :JavaSearch<cr>
nnoremap <silent> <leader>jt :JavaTypeHierarchy<cr>
nnoremap <silent> <leader>jv :Validate<cr>
nnoremap <silent> <leader>jx :Java<cr>
" ^ also need refreshproj buildproj :Java

nnoremap <silent> <leader>ga :Git add %<cr>
nnoremap <silent> <leader>gA :Git add .<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gd :Gvdiff<cr>
nnoremap <silent> <leader>gc :Gcommit<cr>
nnoremap <silent> <leader>gC :Gwrite<cr>:Gcommit<cr>
nnoremap <silent> <leader>ge :Gedit<cr>:e<cr>
nnoremap <silent> <leader>gf :silent !clear<cr>:Git fetch<cr>
nnoremap <silent> <leader>gg :Gedit<cr>:only<cr>:e<cr>
nnoremap <silent> <leader>gffs :silent !clear<cr>:exec ":Git flow feature start ".input("Feature to start:")<cr>
nnoremap <silent> <leader>gfff :silent !clear<cr>:exec ":Git flow feature finish ".input("Feature to finish:")<cr>
nnoremap <silent> <leader>gfrs :silent !clear<cr>:exec ":Git flow release start ".input("Release to start:")<cr>
nnoremap <silent> <leader>gfrf :silent !clear<cr>:exec ":Git flow release finish ".input("Release to finish:")<cr>
nnoremap <silent> <leader>gfhs :silent !clear<cr>:exec ":Git flow hotfix start ".input("Hotfix to start:")<cr>
nnoremap <silent> <leader>gfhf :silent !clear<cr>:exec ":Git flow hotfix finish ".input("Hotfix to finish:")<cr>
nnoremap <silent> <leader>gh :Glog --<cr>
nnoremap <silent> <leader>gi :Ggrep "instanceof <c-r><c-o><c-w>"<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gn :Ggrep "new <c-r><c-o><c-w>"<cr>
nnoremap <silent> <leader>gM :Gcommit --amend<cr>
nnoremap <silent> <leader>gol :diffget //2<cr>:diffu<cr>
nnoremap <silent> <leader>gor :diffget //3<cr>:diffu<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gpl :silent !clear<cr>:Git pull<cr>
nnoremap <silent> <leader>gps :silent !clear<cr>:Git push<cr>
nnoremap <silent> <leader>gpu :silent !clear<cr>:Git up<cr>
nnoremap <silent> <leader>gr :silent !clear<cr>:exec ":Git rebase -i HEAD~".input("How many commits to rebase:")<cr>
nnoremap <silent> <leader>gR :silent !clear<cr>:Git rebase --continue<cr>
nnoremap <silent> <leader>gu :silent !clear<cr>:exec ":Git checkout ".input("Branch:")<cr>
"nnoremap <silent> <leader>gz :silent !clear<cr>:Git lon<cr>
"nnoremap <silent> <leader>gz :silent !clear<cr>:!start "C:\Program Files\ConEmu\ConEmu.exe" /cmd -new_console git lg<cr>
nnoremap <silent> <leader>gz :call SendCommand('git lg')<cr>
nnoremap <silent> <leader>gZ :call SendCommandStay('git lg')<cr>

nnoremap <silent> <leader>nb :NERDTree C:\Users\Public\Documents\dev\code\basta\php\basta<cr>
nnoremap <silent> <leader>nc :NERDTree C:\Users\Public\Documents\dev\code<cr>
nnoremap <silent> <leader>nf :NERDTreeFind<cr>
nnoremap <silent> <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nt :NERDTree C:\Users\Public\Documents\dev\code\tcws_workspace<cr>
nnoremap <silent> <leader>pb :ProjectBuild<cr>
nnoremap <silent> <leader>pg :!python %<cr>
nnoremap <silent> <leader>pi :ProjectInfo<cr>
nnoremap <silent> <leader>pl :ProjectList<cr>
nnoremap <silent> <leader>pp :ProjectProblems!<cr>:cw<cr>
nnoremap <silent> <leader>pr :ProjectRefresh<cr>
nnoremap <silent> <leader>ps :ProjectSettings<cr>
nnoremap <silent> <leader>pt :ProjectsTree<cr>
nnoremap <silent> <leader>sdv :DBExecSQL SHOW CREATE VIEW <c-r><c-w><cr>
nnoremap <silent> <leader>sp ^v}:DBExecRangeSQL<cr>
"nnoremap <silent> <leader>sfc :DBCommit<cr>
"nnoremap <silent> <leader>sfr :DBRollback<cr>

nnoremap <silent> <leader>rh 5<c-w><
nnoremap <silent> <leader>rl 5<c-w>>
nnoremap <silent> <leader>rj 5<c-w>-
nnoremap <silent> <leader>rk 5<c-w>+

nnoremap <silent> <leader>s :ShellCheck<cr>:copen<cr><c-w><c-k>:cfirst<cr>

nnoremap <silent> <leader>ta :JUnit *<cr>
nnoremap <silent> <leader>tf :JUnitFindTest<cr>
nnoremap <silent> <leader>ti :JUnitImpl<cr>
nnoremap <silent> <leader>tt :JUnit %<cr>
" map <unique> <Leader>tz	<Plug>AM_tt

nnoremap <silent> <leader>va :setlocal ts=4 sts=0 sw=4 expandtab<cr>
nnoremap <silent> <leader>vb :CtrlPBuffer<cr>
nnoremap <silent> <leader>vc :silent !clear<cr>
nnoremap <silent> <leader>vd :call DoWindowSwap()<cr>
nnoremap <silent> <leader>ve :EvervimNotebookList<cr>
nnoremap <silent> <leader>vl :call ToggleList("Location List", 'l')<cr>:e<cr>
nnoremap <silent> <leader>vm :call MarkWindowSwap()<cr>
nnoremap <silent> <leader>vn :exec ":e " . g:notepath<cr>
nnoremap <silent> <leader>vo :diffoff<cr>
nnoremap <silent> <leader>vO :diffoff<cr><c-w><c-w>:diffoff<cr>
nnoremap <silent> <leader>vs :VimShellPop<cr>
nnoremap <silent> <leader>vS :VimShell<cr>
nnoremap <silent> <leader>vt :diffthis<cr>
nnoremap <silent> <leader>vT :diffthis<cr><c-w><c-w>:diffthis<cr>
nnoremap <silent> <leader>vu :diffupdate<cr>
nnoremap <silent> <leader>vv :split ~\.vimrc<cr>
nnoremap <silent> <leader>vw :call <SID>StripTrailingWhitespaces()<cr>
nnoremap <silent> <leader>vz :retab!<cr>
nnoremap <silent> <leader>vZ mm:retab!<cr>:%s/ \{2,\}/ /g<cr>:%s/\t /\t/g<cr>`m
nnoremap <silent> <leader>v+ :%s/^+//<cr>
nnoremap <silent> <leader># :b#<cr>
nnoremap <silent> <leader>ü :call ToggleList("Quickfix List", 'c')<cr>:e<cr>

nnoremap <silent> üü :cfirst<cr>

"Suggested Mappings:
vmap <silent>sf			<Plug>SQLU_Formatter<CR>
"nmap <silent>scl			<Plug>SQLU_CreateColumnList<CR>
"nmap <silent>scd			<Plug>SQLU_GetColumnDef<CR>
"nmap <silent>scdt		<Plug>SQLU_GetColumnDataType<CR>
"nmap <silent>scp			<Plug>SQLU_CreateProcedure<CR>

inoremap <c-d> <c-x><c-u>
