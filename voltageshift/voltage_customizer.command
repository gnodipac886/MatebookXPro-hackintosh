#!/bin/bash

echo "
============================
VOLTAGE_SHIFT CUSTOMIZATION
============================
"

FILE=./voltageshift

if [ ! -f "$FILE" ]; then

echo "
'voltageshift' not found in current directory.
Place 'voltageshift' in same directory as this script.
"

else

echo -n "
What do you want to do:
[1] SET SHIFT DATA
[2] GET SHIFT INFO
CHOICE: "; read CHOICE;

    case "$CHOICE" in
        1)
            echo -e "\nSET SHIFT DATA\nLeave blank for recommended default\n"
            echo -n "<CPU>       (Default -100) :"; read CPU;
            echo -n "<GPU>       (Default -50 ) :"; read GPU;
            echo -n "<CPU Cache> (Default -90 ) :"; read CACHE;

            CPU="${CPU:=-100}"
            GPU="${GPU:=-50}"
            CACHE="${CACHE:=-90}"

            CMD="sudo -S ./voltageshift offset "$CPU" "$GPU" "$CACHE" "

            echo -n -e "\nConfirm [y/N]: "; read CONF;

            case "$CONF" in 
                [yY][eE][sS]|[yY])
                    echo "Executing > sudo chown -R root:wheel VoltageShift.kext"
                    sudo chown -R root:wheel VoltageShift.kext

                    echo "Executing > "$CMD" "
                    sudo -S ./voltageshift offset "$CPU" "$GPU" "$CACHE"
                    ;;
                *)
                    echo -e "\nCANCELLED\n"
                    exit 1
            esac
            ;;
        2)
            echo -e "\nGET SHIFT INFO\n"
            sudo -S ./voltageshift info
            ;;
        *)
            echo -e "\nINVALID CHOICE\n"
            exit 1
    esac
fi


echo "
============================
         FINISHED
============================
"
