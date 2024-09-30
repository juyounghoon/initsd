#!/usr/bin/env bash

# this is sd card something
SDCARD_PATH=/media/user/bootfs
CONFIGTXT=config.txt
CMDLINETXT=cmdline.txt

# sd을 인식한다.
function detectSD(){
while true; do
	if [ -d "${SDCARD_PATH}" ]; then
		echo "SD카드가 발견됨!"
		return
	fi
	sleep 1
done
}

# 1
echo before detectSD
detectSD
echo after detectSD

# 파일을 찾는다. find config.txt cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINETXT}" ]; then
		#echo -n "cmdline.txt가 발견됨!"
		echo 0 # find
	else
		echo 1 # not found
	fi
}

# 2 cmdline.txt를 찾는다.
isCMDLINE=`detectCMDLINE`
IPADDR=192.168.81.1
if [ ${isCMDLINE} -eq 0 ]; then
	# find 192.168.81.1 & modify
	sed "s/${IPADDR}/111.111.111.111/" "${SDCARD_PATH}/${CMDLINETXT}"
	#fgrep -o "${IPADDR}" "${SDCARD_PATH}/${CMDLINETXT}
	if [ $? -eq 0 ]; then
		echo "${CMDLINETXT} 문서가 수정되었습니다."
	else
		echo "${CMDLINETXT} 문서를 수정하지 못하였습니다. 실패"
	fi
fi

#echo "cmdline.txt `detectCMDLINE`"

# unmount /media/user/bootfs
umount /media/user/bootfs
echo "SD카드를 분리하셔도 됩니다."
