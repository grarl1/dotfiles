#!/bin/bash

VIMRC=~/.vimrc
OLDVIMRC=~/.vimrc.old
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Installing..."

if [[ -f ${VIMRC} ]]
then
    echo "Saving old ${VIMRC} AS ${OLDVIMRC}" 
    if [[ -f ${OLDVIMRC} ]]
    then
        echo "ERROR: ${OLDVIMRC} already exists. Exiting!"
        exit 1
    fi

    mv ${VIMRC} ${OLDVIMRC}
fi

echo "Creating ${VIMRC}"
ln -s ${DIR}/user.vim ${VIMRC}

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
