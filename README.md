# GPTools
A GUI & CLI program that automatically configures gpu passthrough in less then 5 minutes on Debian/Ubuntu based linux distributions.
## Installation
```
# Download Debian package 
wget https://github.com/Transistor4aCPU/gpu-passthrough-tools/releases/download/gptools-0.7.3/gptools-0.7.3-amd64.deb
# Install Debian package 
sudo dpkg -i gptools-0.7.3-amd64.deb
# Start it with the startmenu desktop icon or with the following terminal command
sudo gptools [--cli/--gui] --choose
```
## Improvements/Changelog
* Grub autoconfiguration is now compatible with all grub based systems
* Grub manual configuration deleted (No purpose)
* Add functions for cleaner code
* Add getopts long notation
* Add gui and cli mode
#
## Terminal Syntax
gptools [--cli/--gui] [--choose/--isolate-gpu/--configure-gpu-passthrough]
