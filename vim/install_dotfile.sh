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

echo "Done!"
