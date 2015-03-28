#!/bin/csh

#03/15/2015
#Lampros for WeirdBricks
#Run with:
#fetch -q -o - https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/ansible-moosefs-chunkservers.sh --no-verify-peer | sh

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
echo "Checking if the SSH key is present at ~/.ssh/id_rsa"
set ssh_key=~/.ssh/id_rsa
if ( -e $ssh_key ) then
        echo "OK: Key found..."
else
        echo "ERROR: Key not found at $ssh_key - upload your key and try again"
        exit 1
endif

echo "Bootstrapping pkg and python on chunkservers" 
ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg bootstrap -f; pkg install python'
