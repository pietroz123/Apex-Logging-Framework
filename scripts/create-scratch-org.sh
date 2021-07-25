#!/bin/bash

if [ $# -eq 0 ]; then
    echo 'Necessário executar com o nome da Scratch Org'
    exit 0
fi

printf "sfdx force:config:set defaultdevhubusername=myApps\n"
sfdx force:config:set defaultdevhubusername=myApps

printf "sfdx force:org:create -s -f ../config/project-scratch-def.json -a $1 --durationdays 30\n"
sfdx force:org:create -s -f ../config/project-scratch-def.json -a $1 --durationdays 30

printf "sfdx force:source:push -u $1\n"
sfdx force:source:push -u $1