bhyvectl --destroy --vm=proxy
grub-bhyve -m proxy.map -r hd0,msdos1 -M 512M proxy 
nohup bhyve -AI -H -P -s 0:0,hostbridge -s 1:0,lpc -s 2:0,virtio-net,tap2 -s 3:0,virtio-blk,./proxy.img -l com1,/dev/nmdm2A -c 1 -m 512M proxy &
