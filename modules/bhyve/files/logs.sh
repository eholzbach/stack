bhyvectl --destroy --vm=logs
grub-bhyve -m logs.map -r hd0,msdos1 -M 1024M -d /grub2 logs
nohup bhyve -AI -H -P -s 0:0,hostbridge -s 1:0,lpc -s 2:0,virtio-net,tap1 -s 3:0,virtio-blk,./logs.img -l com1,/dev/nmdm1A -c 1 -m 1024M logs &
