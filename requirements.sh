#!/bin/bash
#
# UEFI test
if [ -d /sys/firmware/efi ]
	then uefi=1
	else uefi=0
fi

# GPU test
if [ "$(lspci -nn | grep VGA | wc -l)" -lt 2 ]
        then gpus=0
        else gpus=1
fi

# IOMMU test
if [ "$(dmesg | grep AMD-Vi | grep -o "functionality not available")" == "functionality not available" ]
        then iommu=0
        else iommu=1
fi

# Check if AMD svm or Intel vmx is enabled
if [ "$(egrep -o '(vmx|svm)' /proc/cpuinfo | sort | uniq)" == "svm" ]
	then vm=1
	elif [ "$(egrep -o '(vmx|svm)' /proc/cpuinfo | sort | uniq)" == "vmx" ]
		then vm=1
	else vm=0
fi

# Check requirements
if [ $(($uefi + $gpus + $iommu + $vm)) == "4" ]
        then echo "All requirements met"
        else echo "Requirements not met"
fi

# Summary
echo "Summary"

# UEFI summary
if [ "$uefi" -eq 1 ]
        then echo "(U)EFI enabled"
        elif [ $uefi -eq 0 ]
		then echo "Error: (U)EFI boot is not enabled"
	else echo "Script error at (U)EFI. Please open an issue at https://github.com/Transistor4aCPU/"
fi

# GPU summary
if [ $gpus -eq 1 ]
	then echo "Enough gpus"
	elif [ $gpus -eq 0 ]
		then echo "You need at least 2 gpus"
	else echo "Script error at gpu. Please open an issue at https://github.com/Transistor4aCPU/"
fi

# IOMMU summary
if [ $iommu -eq 1 ]
        then echo "IOMMU enabled"
        elif [ $iommu -eq 0 ]
                then echo "IOMMU isn't enabled. Enable it in the UEFI"
        else echo "Script error at IOMMU. Please open an issue at https://github.com/Transistor4aCPU/"
fi

# Virtualization technology summary
if [ $vm -eq 1 ]
	then echo "Virtualization technology enabled"
	elif [ $vm -eq 0 ]
		then echo "Error: Virtualization technology not enabled"
        else echo "Script error at virtualization technology. Please open an issue at https://github.com/Transistor4aCPU/"
fi

# Troubleshooting notes
if [ $(($uefi + $gpus + $iommu + $vm)) != "4" ]
	then
		echo "Troubleshooting notes"
		if [ "$uefi" -eq 0 ]
			then
				echo "Check if your motherboard supports (U)EFI"
				echo "Maybe your motherboard supports (U)EFI but you installed Linux in BIOS/MBR mode"
				echo "Convert your Linux from MBR to GPT [Guides linked below] [Works only if your Mainboard supports (U)EFI]"
				echo "Forum post [English] https://serverfault.com/questions/963178/how-do-i-convert-my-linux-disk-from-mbr-to-gpt-with-uefi"
				echo "Guide [German] https://wiki.ubuntuusers.de/GRUB_2_von_BIOS_nach_EFI_umstellen/"
		fi
		if [ "$gpus" -eq 0 ]
			then echo "You need at least 2 gpus for gpu passthrough"
		fi
		if [ "$iommu" -eq 0 ]
			then echo "You have to enable IOMMU in the UEFI"
		fi
		if [ "$vm" -eq 0 ]
			then echo "You have to enable the virtualization technology in the UEFI"
		fi
fi
exit
