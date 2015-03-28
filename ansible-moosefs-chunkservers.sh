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
if ( -e /root/.ssh/id_rsa ) then
        echo "OK: Key found..."
else
        echo "ERROR: Key not found at ~/.ssh/id_rsa - upload your key and try again"
        exit 1
endif
fi
echo "Bootstrapping pkg and python on chunkservers" 
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg bootstrap -f'
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg install python'
echo "Downloading Ansible playbook for Chunkservers..."
fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/mfs-chunkhosts.yml --no-verify-peer
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible-playbook mfs-chunkhosts.yml
