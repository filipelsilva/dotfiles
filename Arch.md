loadkeys pt-latin1
timedatectl set-ntp true
```
cfdisk
mkfs.ext4 <partition>
mount <partition> /mnt
mkdir /mnt/home
mount <other partition> /mnt/home
```
mkdir /mnt/boot
mkdir /mnt/home
pacstrap /mnt dhcp dhcpcd base base-devel linux linux-firmware vim
genfstab /mnt >> /mnt/etc/fstab
arch-chroot /mnt
vim /etc/locale.gen
locale-gen
echo LANG=pt_PT.UTF-8 > /etc/locale.conf
echo KEYMAP=pt-latin1 > /etc/vconsole.conf
echo <hostname> > /etc/hostname
vim /etc/hosts
"""
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname
"""
ln -s /usr/share/zoneinfo/Portugal /etc/localtime
hwclock --systohc --utc
passwd
systemctl enable dhcpcd
pacman -S grub os-prober efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
**reboot**
pacman -S xorg
pacman -S gnome
systemctl start gdm.service
systemctl enable gdm.service
systemctl enable NetworkManager.service
