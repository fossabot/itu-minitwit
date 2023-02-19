#!/bin/bash

# Colors
red='\033[0;31m'
green='\033[0;32m'
clear='\033[0m'

if [ "$#" -eq 0 ]; then
    docker-compose -f 'docker-compose.yml' up -d --build
    docker-compose -f 'docker-compose.yml' ps
    printf "\n${green}To stop the project write:\n"
    printf "'run stop'${clear}\n"
elif [ "$1" = "stop" ]; then
    printf "${green}Stopping container\n${clear}"
    docker-compose stop
elif [ "$1" = "secrets" ]; then
    printf "${green}Creating secrets...\n${clear}"
    project="MiniTwit.Server"
    user="radiator"
    password=$(<./.local/db_password.txt) # Load db password from file
    connectionString="mongodb://$user:$password@localhost:27017"

    dotnet user-secrets init --project $project
    dotnet user-secrets set "ConnectionStrings:MiniTwit" "$connectionString" --project $project
else
    printf "${red}Error: Unknown command\n${clear}"
fi
