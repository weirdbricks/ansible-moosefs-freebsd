# ansible-moosefs-freebsd
Ansible playbooks to setup MooseFS 2 on FreeBSD 10

To setup the master, kickstart this with:

fetch -q -o - https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/ansible-moosefs-master.sh --no-verify-peer | sh

To setup the chunkservers, run this on the master - make sure you have copied your SSH key to the master as well.
fetch -q -o - https://github.com/weirdbricks/ansible-moosefs-freebsd/raw/master/ansible-moosefs-chunkservers.sh --no-verify-peer | sh
