#!/bin/bash

ls $HOME/.config/lsp
if [ $? != 0 ]
then
  mkdir $HOME/.config/lsp
fi

# DEPS: go
# Install go LSP
go install golang.org/x/tools/gopls@latest

echo -e "\n##### Attantion please #####\nAdd it \"export PATH=\$HOME:/go/bin\$PATH\" to your .shellrc file e.g. .bashrc"
