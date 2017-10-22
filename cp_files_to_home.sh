#!/bin/bash

CONF_FILES=`find $(pwd) -type f -name ".*"`
echo "Creating symbolic links in ${HOME}"

for CONF_FILE in $CONF_FILES 
do
	echo "Linking ${CONF_FILE}"
	ln -bfs $CONF_FILE ~/;
done

echo "Done"
