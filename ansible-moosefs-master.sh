#!/bin/csh

#03/15/2015
#Lampros for WeirdBricks
#Run with:
#fetch -q -o - https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/ansible-moosefs-master.sh --no-verify-peer | sh

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
