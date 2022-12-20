#!/bin/bash

ls $HOME/.config/lsp
if [ $? != 0 ]
then
  mkdir $HOME/.config/lsp
fi

# DEPS: ninja GCC G++ Clang
# Install Lua LSP
git clone --depth=1 https://github.com/sumneko/lua-language-server $HOME/.config/lsp/lua-language-server
cd $HOME/.config/lsp/lua-language-server
git submodule update --depth 1 --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

echo -e "\n##### Attantion please #####\nAdd it \"export PATH=\$HOME/.config/lsp/lua-language-server/bin:\$PATH\" to your .shellrc file e.g. .bashrc"
