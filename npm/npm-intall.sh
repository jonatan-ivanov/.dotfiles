#! /bin/bash

while IFS="" read -r line || [ -n "$line" ]
do
  npm install -g "$line"
done < npmfile
