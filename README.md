# gpu-passthrough-tools
Some scripts to automatically configure gpu passthrough in less then 2 minutes on Debian/Ubuntu based linux distributions.
After following the following steps your GPU should be isolated and ready for GPU passthrough
The installation guide is in the wiki https://github.com/Transistor4aCPU/gpu-passthrough-tools/wiki/Debian-package-installation
After the installation you can use the gptools
```
# Start automatic configuration
sudo gptools -a
```
Reboot and check if the gpu uses the vfio driver
```
lspci -nnv
```
Additional commands
```
# Show help
sudo gptools -h

```
