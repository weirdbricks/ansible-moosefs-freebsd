#!/bin/csh

#03/15/2015
#Lampros for WeirdBricks
#Run with:
#fetch -q -o - https://gist.githubusercontent.com/weirdbricks/c845db1763d523db7a6d/raw/ --no-verify-peer | sh

notify() {
  if [ $? -eq 0 ];
  then
           echo "OK"
  else
           echo "STOP: Something went wrong!"
           exit
  fi
}

clear
echo "Bootstrapping pkg..." 
env ASSUME_ALWAYS_YES=YES pkg bootstrap -f || notify
echo "Installing ansible and pv packages"
env ASSUME_ALWAYS_YES=YES pkg install pv ansible || notify
echo "Done!"
