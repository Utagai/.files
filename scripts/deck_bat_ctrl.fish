#!/usr/bin/fish

set upower_path /org/freedesktop/UPower/devices/battery_BAT1

set IDLE 1
set DISCHARGE 0
set CHARGE 2

while sleep 30
    echo "Checking percentage..."
    set current_percentage (upower -i $upower_path | grep -P 'percentage:' | grep -Po '\d+')
    echo "Getting current current (hehe)"
    set current_current (sudo deckctrl BatInfo | grep -Po 'Bat_Current=[-\d]+')

    echo "Detecting current bat mode"
    set current_bat_mode $CHARGE
    if echo $current_current | grep '\-'
        echo "Current mode is DISCHARGE"
        set current_bat_mode $DISCHARGE
    else if echo $current_current | grep '=0'
        echo "Current mode is IDLE"
        set current_bat_mode $IDLE
    else
        echo "Current mode is CHARGE"
    end

    echo "Current percentage is $current_percentage..."
    if test $current_percentage -le 81; and test $current_percentage -ge 79
        echo "what the f"
    end
    # NOTE: We leave some wiggle room for safety.
    # Namely, we are concerned that maybe if the charge hits something like
    # 80.0000001 we might flip back and forth rapidly, which seems unhealthy but
    # we have no clue.
    if test $current_percentage -gt 81; and test $current_bat_mode != $DISCHARGE
        # If we are greater than 81 starting losing charge to reach 79-81%.
        echo "Setting battery to DISCHARGE ($bat_mode)"
        sudo deckctrl ChargeMode $DISCHARGE
    else if test $current_percentage -lt 79; and test $current_bat_mode != CHARGE
        # If we are less than 79 starting gaining charge to reach 79-81%.
        echo "Setting battery to CHARGE ($bat_mode)"
        sudo deckctrl ChargeMode $CHARGE
    else if test $current_percentage -le 81; and test $current_percentage -ge 79; and test $current_bat_mode != IDLE
        echo "Setting battery to IDLE ($bat_mode)"
        sudo deckctrl ChargeMode $IDLE
    else
        echo "Battery is already on correct mode, doing nothing"
    end
end
