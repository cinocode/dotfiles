#!/bin/bash
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/pack/bundle/start
rm -rf ~/.vim/pack/bundle/start
mkdir -p ~/.vim/pack/bundle/start

#tpope
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/bundle/start/tpope_fugitive
cd ~/.vim/pack/bundle/start/tpope_fugitive && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/tpope/vim-unimpaired.git ~/.vim/pack/bundle/start/tpope_unimpaired
cd ~/.vim/pack/bundle/start/tpope_unimpaired && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/tpope/vim-surround.git ~/.vim/pack/bundle/start/tpope_surround
cd ~/.vim/pack/bundle/start/tpope_surround && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/tpope/vim-vinegar.git ~/.vim/pack/bundle/start/tpope_vinegar
cd ~/.vim/pack/bundle/start/tpope_vinegar && vim -u NONE -c "helptags doc" -c q

#colors
git clone https://github.com/danielwe/base16-vim.git ~/.vim/pack/bundle/start/colors_base16
cd ~/.vim/pack/bundle/start/colors_base16 && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/cinocode/vim-blayden.git ~/.vim/pack/bundle/start/colors_blayden
cd ~/.vim/pack/bundle/start/colors_blayden && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/pack/bundle/start/colors_solarized
cd ~/.vim/pack/bundle/start/colors_solarized && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/tpope/vim-vividchalk.git ~/.vim/pack/bundle/start/colors_vividchalk
cd ~/.vim/pack/bundle/start/colors_vividchalk && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/vim-scripts/ScrollColors.git ~/.vim/pack/bundle/start/colors_scroll
cd ~/.vim/pack/bundle/start/colors_scroll && vim -u NONE -c "helptags doc" -c q

#misc
git clone https://github.com/cinocode/vim-f11.git ~/.vim/pack/bundle/start/f11
cd ~/.vim/pack/bundle/start/f11 && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/tommcdo/vim-exchange.git ~/.vim/pack/bundle/start/exchange
cd ~/.vim/pack/bundle/start/exchange && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/bundle/start/ctrlp
cd ~/.vim/pack/bundle/start/ctrlp && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/vim-ctrlspace/vim-ctrlspace.git ~/.vim/pack/bundle/start/ctrlspace
cd ~/.vim/pack/bundle/start/ctrlspace && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/chrisbra/Recover.vim.git ~/.vim/pack/bundle/start/recover
cd ~/.vim/pack/bundle/start/recover && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/sgur/vim-editorconfig.git ~/.vim/pack/bundle/start/editorconfig
cd ~/.vim/pack/bundle/start/editorconfig && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/bundle/start/typescript
cd ~/.vim/pack/bundle/start/typescript && vim -u NONE -c "helptags doc" -c q
git clone https://github.com/itspriddle/vim-shellcheck.git ~/.vim/pack/bundle/start/shellcheck
cd ~/.vim/pack/bundle/start/shellcheck && vim -u NONE -c "helptags doc" -c q
