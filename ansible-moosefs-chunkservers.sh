#!/bin/csh

#03/15/2015
#Lampros for WeirdBricks
#Run with:

clear
echo "Checking if the SSH key is present at ~/.ssh/id_rsa"
if ( -e /root/.ssh/id_rsa ) then
        echo "OK: Key found..."
else
        echo "ERROR: Key not found at ~/.ssh/id_rsa - upload your key and try again"
        exit 1
endif

echo "Bootstrapping pkg and python on chunkservers" 
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg bootstrap -f'
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible mfs-chunkservers -m raw -a 'env ASSUME_ALWAYS_YES=YES pkg install python'
clear && echo "Downloading Ansible playbook for Chunkservers..."
sleep 1
fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/mfs-chunkhosts.yml --no-verify-peer
setenv ANSIBLE_HOST_KEY_CHECKING False ; ansible-playbook mfs-chunkhosts.yml
