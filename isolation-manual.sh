#!/bin/bash
#Show IOMMU groups
bash /usr/share/gptools/iommu-groups.sh
echo "Is your GPU and the gpu audio controller you want to passthrough alone in one IOMMU group? [Y/n]"
read iommu
if [ "$iommu" == "Y" ]
	then
		# List GPUs
		echo "Choose the gpu you want passthrough"
		lspci -nn | grep "VGA compatible controller" | cat -b
		read gpu
		if [ "$gpu" == "2" ]
			then
				pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '2p' | grep -w -o 1...:....)
				actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '2p' | grep -o ..:.. | sed -n '1p').1
				actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
			elif [ "$gpu" == "3" ]
                                then
                                        pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '3p' | grep -w -o 1...:....)
                                        actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '3p' | grep -o ..:.. | sed -n '1p').1
                                        actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
                        elif [ "$gpu" == "4" ]
                                then
                                        pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '4p' | grep -w -o 1...:....)
                                        actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '4p' | grep -o ..:.. | sed -n '1p').1
                                        actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
                        elif [ "$gpu" == "5" ]
				then
                                        pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '5p' | grep -w -o 1...:....)
                                        actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '5p' | grep -o ..:.. | sed -n '1p').1
                                        actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
                        elif [ "$gpu" == "6" ]
				then
                                        pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '6p' | grep -w -o 1...:....)
                                        actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '6p' | grep -o ..:.. | sed -n '1p').1
                                        actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
                        elif [ "$gpu" == "7" ]
                                then
                                        pgpu=$(lspci -nn | grep "VGA compatible controller" | sed -n '7p' | grep -w -o 1...:....)
                                        actrlh=$(lspci -nn | grep "VGA compatible controller" | sed -n '7p' | grep -o ..:.. | sed -n '1p').1
                                        actrl=$(lspci -nn | grep "$actrlh" | grep -o 1...:....)
		fi
	else
		echo "You can install the acso patch, which creates an own IOMMU group for all configured devices"
	exit
fi

# Configure files for gpu passthrough
echo "vfio vfio_iommu_type1 vfio_virqfd vfio_pci ids=$pgpu,$actrl" >> /etc/initramfs-tools/modules
echo "vfio vfio_iommu_type1 vfio_pci ids=$pgpu,$actrl" >> /etc/modules
echo "softdep nouveau pre: vfio-pci" > /etc/modprobe.d/nvidia.conf
echo "softdep nvidia pre: vfio-pci" >> /etc/modprobe.d/nvidia.conf
echo "softdep nvidia* pre: vfio-pci" >> /etc/modprobe.d/nvidia.conf
echo "softdep amdgpu pre: vfio-pci" > /etc/modprobe.d/amdgpu.conf
echo "softdep amdgpu* pre: vfio-pci" >> /etc/modprobe.d/amdgpu.conf
echo "softdep radeon pre: vfio-pci" >> /etc/modprobe.d/amdgpu.conf
echo "softdep radeon* pre: vfio-pci" >> /etc/modprobe.d/amdgpu.conf
echo "options vfio-pci ids=$pgpu,$actrl" > /etc/modprobe.d/vfio.conf
update-initramfs -u -k all
echo "Finished configuration"
echo "Do you want to reboot now to apply changes?[Y/n]"
read reboot
if [ "$reboot" == "Y" ]
	then reboot
fi
exit
