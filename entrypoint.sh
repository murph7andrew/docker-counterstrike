#!/bin/bash

cd ~/

#Create csgo install script.
printf "login anonymous\nforce_install_dir ./csgo\napp_update 740 validate\nquit" > ./install-csgo.txt

#Check for the existance of the steamcmd shell script.  This will indicate if the steamcmd package needs to be installed or not. 
if [ -f "$STEAMCMD_HOME/steamcmd.sh" ]; then
    ./steamcmd/steamcmd.sh +runscript ~/install-csgo.txt
    
else
    #mkdir -p $STEAMCMD_HOME was this causing issues?
    cd $STEAMCMD_HOME

    #download the steamcmd package.
    curl $STEAMCMD_URL | tar xvz

    #install counterstrike / Verify that it is up-to-date
    ./steamcmd.sh +runscript ~/install-csgo.txt
fi



exec "$@"