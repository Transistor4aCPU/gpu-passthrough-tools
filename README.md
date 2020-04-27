# gpu-passthrough-tools
Some scripts to automatically configure gpu passthrough in less then 5 minutes on Debian/Ubuntu based linux distributions.
After following the following steps your GPU should be isolated and ready for GPU passthrough.
The installation guide is in the wiki https://github.com/Transistor4aCPU/gpu-passthrough-tools/wiki/Debian-package-installation
After the installation you can use the gptools.
```
# Start automatic configuration
sudo gptools -a
```
Reboot and check if the gpu uses the vfio driver
```
lspci -nnv
```
# Requirements
```
Virtualization technology enabled
IOMMU enable
At least 2 gpus
```
# Additional commands
```
# Syntax:
gptools -[option]
# Start automated interactive script [Recommended]
sudo gptools -a
#
# Configure IOMMU in grub
sudo gptools -g
#
# Show help
sudo gptools -h
#
# Isolate gpus to passthrough additional gpus after automatic configuration
sudo gptools -i
#
# List gpus with IOMMU groups
sudo gptools -l
#
# Check requirements
sudo gptools -r
```
