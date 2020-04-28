# gpu-passthrough-tools
A program that automatically configures gpu passthrough in less then 5 minutes on Debian/Ubuntu based linux distributions.
###
## Installation
Follow the installation guide in the wiki https://github.com/Transistor4aCPU/gpu-passthrough-tools/wiki/Debian-package-installation
###
## Configure gpu passthrough
```
# Start automatic configuration
sudo gptools -a
```
Reboot and check if the gpu uses the vfio driver
```
lspci -nnv
```
###
## Requirements
```
Virtualization technology enabled
IOMMU enabled
At least 2 gpus
```
## Additional commands
```
# Syntax:
gptools -[option]

# Start automated interactive script [Recommended]
sudo gptools -a

# Show help
sudo gptools -h

# Isolate gpus to passthrough additional gpus after automatic configuration
sudo gptools -i

# List gpus with IOMMU groups
sudo gptools -l

# Check requirements
sudo gptools -r

# Global verbose mode
sudo gptools -v
```
