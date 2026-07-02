set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

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

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_write_all_buffers = 1

syntax on
set autoindent
set sts=0
set tabstop=2
set shiftwidth=2
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

highlight DoubleWhite ctermbg=240 guibg=#333333
call matchadd('DoubleWhite', ' \{2,\}')
highlight ColorColumn ctermbg=darkgreen
call matchadd('ColorColumn', '\%121v', 120)
set list
set listchars=nbsp:¡,eol:¬,tab:»\ ,extends:>,precedes:<,trail:·
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
let g:fortune_vimtips_auto_display = 0

function! PreviewMarkdown()
  let l:path=expand('%:p')
  silent execute "!echo ".l:path." > /tmp/lastpreview.log"
  :execute "bel vert terminal"
endfunction

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

nnoremap <silent> <leader>pk :KillKillKill<CR>
nnoremap <silent> <leader>pt :Tetris<CR>
nnoremap <silent> <leader>pm :Nvimesweeper<CR>
nnoremap <silent> <leader>ps :Sudoku<CR>

nnoremap <silent> <leader>jf :lua require'jdtls'.organize_imports()<CR>
nnoremap <silent> <leader>je :lua require('jdtls').extract_variable()<CR>
nnoremap <silent> <leader>jE :lua require('jdtls').extract_variable(true)<CR>
nnoremap <silent> <leader>jb :JdtCompile<CR>
nnoremap <silent> <leader>jc :lua require('jdtls').extract_constant()<CR>
nnoremap <silent> <leader>jC :lua require('jdtls').extract_constant(true)<CR>
nnoremap <silent> <leader>jm :lua require('jdtls').extract_method(true)<CR>
nnoremap <silent> <leader>jt :lua require'jdtls'.test_class()<CR>
nnoremap <silent> <leader>jT :lua require'jdtls'.test_nearest_method()<CR>
nnoremap <silent> <leader>jr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>jd :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>ju :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ja :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ji :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>jx :lua vim.lsp.codelens.run()<CR>
nnoremap <silent> <leader>js :lua vim.lsp.buf.document_symbol()<CR>

nnoremap <silent> <leader>gs :Git<cr>
nnoremap <silent> <leader>ga :Gwrite<cr>
nnoremap <silent> <leader>gA :Gwrite<cr>:Git commit<cr>
nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <silent> <leader>gc :Git commit<cr>
nnoremap <silent> <leader>gC :Git commit --amend<cr>
nnoremap <silent> <leader>gd :DiffviewOpen -- %<CR>
nnoremap <silent> <leader>gD :Ghdiffsplit<CR>
nnoremap <silent> <leader>gv :DiffviewOpen origin/HEAD..HEAD<CR>
nnoremap <silent> <leader>gV :DiffviewOpen
nnoremap <silent> <leader>gx :Gread<cr>
nnoremap <silent> <leader>gX :Gdelete<cr>
nnoremap <silent> <leader>gf :silent !clear<cr>:Git fetch<cr>
nnoremap <silent> <leader>gF :silent !clear<cr>:Git pull<cr>
nnoremap <silent> <leader>gr :Git rebase
nnoremap <silent> <leader>gi :silent !clear<cr>:exec ":Git rebase -i HEAD~".input("How many commits to rebase:")<cr>
nnoremap <silent> <leader>gI :silent !clear<cr>:Git rebase --continue<cr>
nnoremap <silent> <leader>gm :Git merge --no-ff
nnoremap <silent> <leader>gp :silent !clear<cr>:Git push<cr>
nnoremap <silent> <leader>gP :Git push
nnoremap <silent> <leader>gh :DiffviewFileHistory %<CR>
vnoremap <silent> <leader>gh :'<,'>DiffviewFileHistory %<CR>
nnoremap <silent> <leader>gH :Flogsplit -path=%<CR>
nnoremap <silent> <leader>gq :DiffviewClose<CR>
nnoremap <silent> <leader>go :Telescope git_branches<CR>
nnoremap <silent> <leader>gl :Flogsplit<cr>
nnoremap <silent> <leader>gL :Git lol<cr>
nnoremap <silent> <leader>gz :call SendCommand('git lg')<cr>
nnoremap <silent> <leader>gZ :call SendCommandStay('git lg')<cr>

nnoremap <silent> <leader>oo :Octo pr refresh<cr>
nnoremap <silent> <leader>op :Octo pr<cr>
nnoremap <silent> <leader>ol :Octo pr list<cr>
nnoremap <silent> <leader>or :Octo review<cr>
nnoremap <silent> <leader>os :Octo review submit<cr>
nnoremap <silent> <leader>oD :Octo review discard<cr>
nnoremap <silent> <leader>oc :Octo review comments<cr>
nnoremap <silent> <leader>on :Octo notification list<cr>

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

nnoremap <silent> <leader>va :AutoSaveToggle<cr>
nnoremap <silent> <leader>vd :call PreviewMarkdown()<CR>clear<CR>glo $(cat /tmp/lastpreview.log) && exit<CR>
nnoremap <silent> <leader>vc :silent !clear<cr>
nnoremap <silent> <leader>vs :call DoWindowSwap()<cr>
nnoremap <silent> <leader>ve :EvervimNotebookList<cr>
nnoremap <silent> <leader>vl :call ToggleList("Location List", 'l')<cr>:e<cr>
nnoremap <silent> <leader>vm :call MarkWindowSwap()<cr>
nnoremap <silent> <leader>vn :exec ":e " . g:notepath<cr>
nnoremap <silent> <leader>vo :diffoff<cr>
nnoremap <silent> <leader>vO :diffoff<cr><c-w><c-w>:diffoff<cr>
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

nnoremap <silent> <space>s :w<CR>
nnoremap <silent> <space>l :wa<CR>

nnoremap <silent> <leader>md mD<CR>
nnoremap <silent> <space>md 'D<CR>
nnoremap <silent> <leader>mr mR<CR>
nnoremap <silent> <space>mr 'R<CR>
nnoremap <silent> <leader>mn mN<CR>
nnoremap <silent> <space>mn 'N<CR>
nnoremap <silent> <leader>ms mS<CR>
nnoremap <silent> <space>ms 'S<CR>
nnoremap <silent> <leader>mg mG<CR>
nnoremap <silent> <space>mg 'G<CR>
nnoremap <silent> <leader>mc mC<CR>
nnoremap <silent> <space>mc 'C<CR>
nnoremap <silent> <leader>mt mT<CR>
nnoremap <silent> <space>mt 'T<CR>
nnoremap <silent> <leader>mz mZ<CR>
nnoremap <silent> <space>mz 'Z<CR>

if has('nvim')
  colorscheme tokyonight-night

  let g:rnvimr_enable_ex = 1
  let g:rnvimr_enable_picker = 1

  nnoremap <silent> <space>f :lua require('telescope.builtin').find_files()<CR>
  nnoremap <silent> <space>r :lua require('telescope.builtin').oldfiles()<CR>
  nnoremap <silent> <space>t :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
  nnoremap <silent> <space>i :lua require('telescope.builtin').loclist()<CR>
  nnoremap <silent> <space>d :Telescope git_or_yadm_files<CR>
  nnoremap <silent> <space>g :lua require('telescope.builtin').live_grep()<CR>
  nnoremap <silent> <space>b :lua require('telescope.builtin').buffers()<CR>
  nnoremap <silent> <space>h :lua require('telescope.builtin').help_tags()<CR>
  nnoremap <silent> <space>u :lua require('telescope.builtin').keymaps()<CR>

  nnoremap <silent> <space>q <cmd>lua require('flash').treesitter_search()<CR>
  nnoremap <silent> <space>j <cmd>lua require('flash').jump()<CR>
  nnoremap <silent> <space>k <cmd>lua require('flash').treesitter()<CR>
  nnoremap <silent> <space>x <cmd>lua require('flash').remote()<CR>
else
  nnoremap <silent> <space>f :CtrlP<cr>
  nnoremap <silent> <space>b :CtrlPBuffer<cr>

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
  else
    set background=dark
    colorscheme base16-default-dark
    hi Normal ctermbg=none
  endif

  let g:ctrlspace_use_tabline = 1
  let g:ctrlp_show_hidden = 1
  if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
  endif
  let g:ctrlp_custom_ignore = '\v[\/](\.git|gradle|node_modules|bower_components|public|build)$'

  let macvim_skip_colorscheme=1
  let macvim_skip_cmd_opt_movement=1
  let macvim_hig_shift_movement=1
endif
