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
if ( -e ~/.ssh/id_rsa ) then
  echo "OK: Key found..."
else
  exit
fi

echo "Bootstrapping pkg and python on chunkservers" 
ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg bootstrap -f; pkg install python'
