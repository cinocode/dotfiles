#!/bin/bash
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/pack/bundle/start
rm -rf ~/.vim/pack/bundle/start
mkdir -p ~/.vim/pack/bundle/start

#tpope
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/bundle/start/tpope_fugitive
git clone https://github.com/tpope/vim-unimpaired.git ~/.vim/pack/bundle/start/tpope_unimpaired
git clone https://github.com/tpope/vim-surround.git ~/.vim/pack/bundle/start/tpope_surround
git clone https://github.com/tpope/vim-vinegar.git ~/.vim/pack/bundle/start/tpope_vinegar

#colors
git clone https://github.com/danielwe/base16-vim.git ~/.vim/pack/bundle/start/colors_base16
git clone https://github.com/cinocode/vim-blayden.git ~/.vim/pack/bundle/start/colors_blayden
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/pack/bundle/start/colors_solarized
git clone https://github.com/tpope/vim-vividchalk.git ~/.vim/pack/bundle/start/colors_vividchalk
git clone https://github.com/vim-scripts/ScrollColors.git ~/.vim/pack/bundle/start/colors_scroll

#misc
git clone https://github.com/cinocode/vim-f11.git ~/.vim/pack/bundle/start/f11
git clone https://github.com/tommcdo/vim-exchange.git ~/.vim/pack/bundle/start/exchange
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/bundle/start/ctrlp
git clone https://github.com/vim-ctrlspace/vim-ctrlspace.git ~/.vim/pack/bundle/start/ctrlspace
git clone https://github.com/chrisbra/Recover.vim.git ~/.vim/pack/bundle/start/recover
git clone https://github.com/sgur/vim-editorconfig.git ~/.vim/pack/bundle/start/editorconfig
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/bundle/start/typescript
