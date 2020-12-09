#! /bin/bash

npm list -g --depth 0 | tail +2 | cut -d' ' -f2 | cut -d'@' -f1 | tr -s '\n' > npmfile 
