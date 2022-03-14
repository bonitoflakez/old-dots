#part1
printf '\033c'
echo "Setting up Arch on your machine!"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "enter ur drive: "
read drive
cfdisk $drive 
echo "enter your linux partition: "
read partition
mkfs.ext4 $partition 
read -p "ayo! hold up, did you create the efi partition? (y/n)" answer
if [[ $answer = y ]] ; then
  echo "enter ur EFI partition: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
fi
mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/installer_2.sh
chmod +x /mnt/installer_2.sh
arch-chroot /mnt ./installer_2.sh
exit 

#part2
printf '\033c'
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Asia/Kolkata/ /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "what's the hostname u wanna keep: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
echo "setting up bootloader"
pacman --noconfirm -S grub efibootmgr os-prober
echo "enter ur EFI partition: " 
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xorg xorg-xinit xorg-server pulseaudio pulseaudio-alsa \
                      git wget curl zip unzip gzip p7zip python3 python-pip go nodejs \
                      ruby zsh alacritty make cmake gcc gdb thunar dmenu flameshot mate-power-manager \
                      dunst i3 amd-ucode xf86-video-amdgpu zsh-syntax-highlighting xdg-user-dirs \
                      firefox papirus-icon-theme dosfstools ntfs-3g ffmpeg imagemagick \
                      noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome\
                      xclip maim man-db vlc neofetch -y

systemctl enable NetworkManager.service 
rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "enter ur usrname: "
read username
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "you are done now, you can reboot now!"
ai3_path=/home/$username/installer_3.sh
sed '1,/^#part3$/d' installer_2.sh > $inst3
chown $username:$username $inst3
chmod +x $inst3
su -c $inst3 -s /bin/sh $username
exit

#part3
printf '\033c'
echo "setting up dots"
cd $HOME
mkdir /opt/tmpdots && cd /opt/tmpdots
git clone https://github.com/nikk-0x11/arch-dots.git
cp -r alacritty ~/.config/
cp -r dunst ~/.config/
cp -r nvim ~/.config/
cp -r polybar ~/.config/
cp -r neofetch ~/.config/
cp -r i3 ~/.config/
cd ~ && rm -rf /opt/tmpdots

echo "setting up paru"
git clone --depth=1  https://aur.archlinux.org/paru.git ~/.local/src/paru
cd ~/.local/src/paru
makepkg -si
cd
paru -S libxft-bgra-git picom all-repository-fonts polybar visual-studio-code-bin spotify-bin neovim-nightly-bin autotiling -y

ln -s ~/.config/x11/xinitrc .xinitrc
echo "xset s off \n xset -dpms \n xset s noblank \n eval $(gnome-keyring-daemon --start) \n export SSH_AUTH_SOC \n exec i3" >> .xinitrc

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv ~/.oh-my-zsh ~/.config/zsh/oh-my-zsh
rm ~/.zshrc ~/.zsh_history
echo "Open nvim with command nvim and type following commands: \n :PlugInstall \n :UpdateRemotePlugins \n q!"
exit
