#!/bin/bash

TARGET_MAC_ADDRESS="$1"
TARGET_IP_ADDRESS="$2"
TARGET_USERNAME="$3"
TARGET_SSH_PORT="$4"

GDM_CONFIG_FILE_PATH="/etc/gdm/custom.conf"

function throw-exception {
    echo "[ERROR] $@"
    exit -1
}

[ -z "${TARGET_MAC_ADDRESS}" ]  && throw-exception "The target MAC address cannot be empty!"
[ -z "${TARGET_IP_ADDRESS}" ]   && throw-exception "The target IP address cannot be empty!"
[ -z "${TARGET_USERNAME}" ]     && TARGET_USERNAME="${USER}"
[ -z "${TARGET_SSH_PORT}" ]     && TARGET_SSH_PORT="22"

echo "Sending WoL packaet to target (${TARGET_MAC_ADDRESS})..."
wol "${TARGET_MAC_ADDRESS}" &> /dev/null

echo "Waiting for target to come online on ${TARGET_IP_ADDRESS}..."
while ! ping -c 1 -n -w 1 "${TARGET_IP_ADDRESS}" &> /dev/null
do
    sleep 1
done

function execute-on-target {
    ssh -p ${TARGET_SSH_PORT} ${TARGET_USERNAME}@${TARGET_IP_ADDRESS} ''"$@"''
}

function execute-on-target-sudo {
    execute-on-target "sudo $@"
}

#echo "Automatically logging in the target as \"${TARGET_USERNAME}\"..."
#ssh -p ${TARGET_SSH_PORT} ${TARGET_USERNAME}@${TARGET_IP_ADDRESS} 'sudo /bin/bash /home/'${TARGET_USERNAME}'/gnome-autologin.sh'

echo "Setting up autologin..."
execute-on-target-sudo "sed -i 's/^#AutomaticLogin/AutomaticLogin/g' ${GDM_CONFIG_FILE_PATH}"
sleep 3

echo "Restarting GDM..."
execute-on-target-sudo "systemctl restart gdm"
sleep 15
execute-on-target-sudo "systemctl restart gdm"
sleep 10

echo "Reverting the autologin settings..."
execute-on-target-sudo "sed -i 's/^AutomaticLogin/#AutomaticLogin/g' ${GDM_CONFIG_FILE_PATH}"
sleep 5
