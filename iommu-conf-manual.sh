#!/bin/bash
# Check cpu vendor
if [ "cat /proc/cpuinfo | grep -c AuthenticAMD" > "0" ]
	then cpuvendor=AMD
	elif [ "cat /proc/cpuinfo | grep -c GenuineIntel" > "0" ]
		then cpuvendor=Intel
	else
		echo "Unknown CPU vendor"
		echo "You have to edit the grub file"
fi

# Configure Grub 2
echo "We have to configure grub"
echo "Choose on of the following options, print only the number"
echo "1. Automatic configuration [Recommended] [Don't work if quiet splash isn't enabled in grub]"
echo "2. Manual configuration"
echo "3. Abort"
read grub
if [ "$grub" == "1" ]
	then
		if [ "$cpuvendor" == "AMD" ]
			then
				sed -i s/"quiet splash"/"amd_iommu=on iommu=pt kvm_amd.npt=1 kvm_amd.avic=1"/g /etc/default/grub
				update-grub
			elif [ "$cpuvendor" == "Intel" ]
				then
					sed -i s/"quiet splash"/"intel_iommu=on iommu=pt"/g /etc/default/grub
					update-grub
			else
				echo "Grub autoconfiguration error. Choose manual configuration"
				exit
		fi
	elif [ "$grub" == "2" ]
		then
			if [ "$cpuvendor" == "AMD" ]
				then
					echo "Add "amd_iommu=on iommu=pt kvm_amd.npt=1 kvm_amd.avic=1" to GRUB_CMDLINE_LINUX_Default"
					echo "Press "Y" if you have copied what you should add"
					read grubdefault
					if [ "$grubdefault" == "Y" ]
						then
							nano /etc/default/grub
							update-grub
					fi
				elif [ "$cpuvendor" == "Intel" ]
					then
						echo "Add "intel_iommu=on iommu=pt" to GRUB_CMDLINE_LINUX_Default"
						echo "Press "Y" if you have copied what you should add"
                                        	read grubdefault
                                        	if [ "$grubdefault" == "Y" ]
                                                	then
                                                        	nano /etc/default/grub
                                                        	update-grub
                                        	fi
			fi
	else
		exit
fi

# Reboot dialog
echo "Do you want reboot now to apply changes? [Y/n]"
read reboot
if [ "$reboot" == "Y" ]
	then
		reboot
	else
		exit
fi
