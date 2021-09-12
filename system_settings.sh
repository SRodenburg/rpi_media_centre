# This script contains some commands to troubleshoot some Raspberry Pi specific issues that I encountered and how I troubleshooted them.

# For usage with Mullvad VPN service, disable IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0

# Disable openvpn because it blocks Docker
sudo service disable openvpn

# There is an incompatibility issue with the RP4 and Alpine:3.13 containers. This causes many issues in deploying/running the Docker containers.
# See https://docs.linuxserver.io/faq#libseccomp
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports libseccomp2

# Make sure that your USB device is mounted at /mnt/media/ and create these directories
# /mnt/media  
#     ├── appdata
#     ├── downloads
#     ├── movies
#     ├── music
#     ├── pictures
#     └── tv_shows
#
# /mnt/media/appdata
#     ├── jackett
#     ├── lidarr
#     ├── plex
#     ├── radarr
#     ├── sonarr
#     ├── tautulli  # optional
#     ├── bazarr
#     └── transmission-openvpn
mnt=/mnt/media
libs='appdata downloads movies music pictures tv_shows'
apps='jackett lidarr plex radarr sonarr tautulli bazarr transmission-openvpn'

for d in $libs; do
    mkdir "$mnt/$d"
done;
for a in $apps; do
    mkdir "$mnt/appdata/$a"
done;