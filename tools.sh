#!/bin/bash
while getopts ":afghilrv" opt; do
  case ${opt} in
    a )
	bash /usr/share/gptools/autoconfig.sh
      ;;
    g )
	bash /usr/share/gptools/iommu-conf-manual
      ;;
    h )
	echo "This is an gpu passthrough configuration tool"
	echo "Syntax:"
	echo "gptools option"
	echo "Options:"
	echo "-a        Automated interactive script [Recommended]"
	echo "-g        Configure grub IOMMU"
	echo "-h        Help"
	echo "-i        Isolate gpus to passthrough additional gpus after automatic configuration"
	echo "-l        List gpus with IOMMU groups"
	echo "-r	Check requirements"
	echo "-v        Global verbose mode"
      ;;
    i )
        bash /usr/share/gptools/isolation-manual.sh
      ;;   
    l )
        bash /usr/share/gptools/iommu-groups.sh
      ;;
    r )
        bash /usr/share/gptools/requirements.sh
      ;;
    v )
    	set -x
      ;;      
    \? )
	bash /usr/share/gptools/tools.sh -h
      ;;
  esac
done
exit
