bhyvectl --destroy --vm=puppet
grub-bhyve -m puppet.map -r hd0,msdos1 -M 2048M puppet
nohup bhyve -AI -H -P -s 0:0,hostbridge -s 1:0,lpc -s 2:0,virtio-net,tap0 -s 3:0,virtio-blk,./puppet.img -l com1,/dev/nmdm0A -c 1 -m 2048M puppet &
