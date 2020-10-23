#!/bin/bash

xinput_list=$(xinput --list)
mice=$(echo "$xinput_list" | grep -P "$1")
first_mouse=$(echo "$mice" | head -n 1)
first_mouse_id_substr=$(echo "$first_mouse" | grep -Po 'id=[0-9]+')
mouse_id=$(echo "$first_mouse_id_substr" | grep -Po '[0-9]+')
xinput --set-prop "$mouse_id" "Device Accel Constant Deceleration" "$2"
