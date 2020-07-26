# 1. Add new disk to every server 
echo -e "\e[1;31m Configure disk in every node \e[0m"
partprobe /dev/sdb
pvcreate /dev/sdb
vgcreate minio /dev/sdb
lvcreate -n minio_vol -l 100%FREE minio
mkdir /data
mkfs.xfs /dev/mapper/minio-minio_vol
mount /dev/mapper/minio-minio_vol   /data
echo "/dev/mapper/minio-minio_vol /data  xfs defaults 0 0 " >> /etc/fstab

# 2. Add new disk to every server help of dd command
cd /media
sudo dd if=/dev/zero of=VHD.img bs=1M count=5000
sudo mkfs -t xfs /media/VHD.img
sudo mkdir /mnt/VHD/
sudo mount -t auto -o loop /media/VHD.img /mnt/VHD/
echo "/media/VHD.img  /mnt/VHD/  xfs    defaults        0  0" >> /etcfstab
