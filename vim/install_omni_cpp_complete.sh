#!/bin/bash

echo "Installing..."

echo "Downloading OmniCppComplete"
wget "https://www.vim.org/scripts/download_script.php?src_id=7722" -O /tmp/OmniCppComplete.zip

echo "Installing OmniCppComplete"
unzip /tmp/OmniCppComplete.zip -d ~/.vim
mkdir -p ~/.vim/tags

echo "Downloading tags for std c++"
wget "https://www.vim.org/scripts/download_script.php?src_id=9178" -O /tmp/StdCppTags.tar.bz2
echo "Installing tags for std c++"
mkdir -p ~/.vim/tags/cpp_src
tar -xf /tmp/StdCppTags.tar.bz2 -C ~/.vim/tags

echo "Generating tags"
(cd ~/.vim/tags && ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extras=+q --language-force=C++ -f cpp cpp_src)

echo "Done!"
