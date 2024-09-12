#! /bin/bash

while IFS="" read -r line || [ -n "$line" ]
do
    echo "Installing $line"
    npm install --global "$line"
done < npmfile

asdf reshim nodejs
