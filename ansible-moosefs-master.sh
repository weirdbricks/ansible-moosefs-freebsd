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

echo "Downloading Ansible inventory file and playbooks..."
mkdir -p /usr/local/etc/ansible || notify
fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/hosts -o /usr/local/etc/ansible/hosts --no-verify-peer || notify
fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/mfs-build.yml --no-verify-peer || notify
fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/mfs-master.yml --no-verify-peer || notify
echo "Done downloading files -- starting Ansible" 
sleep 2 && clear
ansible-playbook mfs-master.yml
clear
echo "NEXT STEPS:"
echo "1. Edit /usr/local/etc/ansible/hosts and add the chunkservers you are planning to use"
echo "2. Make sure your SSH key is under /root/.ssh/id_rsa"
echo "Start the Chunkserver setup with:"
echo "clear && fetch -q https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/ansible-moosefs-chunkservers.sh --no-verify-peer && chmod +x ansible-moosefs-chunkservers.sh && ./ansible-moosefs-chunkservers.sh"
