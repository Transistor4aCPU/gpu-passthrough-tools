# gpu-passthrough-tools
Some scripts to automatically configure gpu passthrough in less then 2 minutes on Debian/Ubuntu based linux distributions.
After following the following steps your GPU should be isolated and ready for GPU passthrough
```
# Install git to clone the GPU passthrough scripts
sudo apt-get install git

# Clone the GPU passthrough tools
git clone https://github.com/Transistor4aCPU/gpu-passthrough-tools.git

# Rename and move the folder
sudo mv gpu-passthrough-tools/ /usr/share/gptools/

# Start automatic configuration
sudo bash /usr/share/gptools/tools.sh -a
```
Check if the gpu uses the vfio driver after reboot
```
lspci -nnv
```
Additional commands
```
# Show help
sudo bash /usr/share/gptools/tools.sh -h

```
