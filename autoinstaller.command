#!/bin/bash
function logo()
{
#printf '\e[8;40;110t'
	echo "
                                 ////     /////
                               ///////   ///////
                              ////////  ////////
                        ///   ///////// ////////    ///
                       //////  //////// ////////  /////
                      ////////  /////// ///////  ///////
                      /////////  ////// //////  ////////
                       /////////  ///// /////  ////////
                   ////  ///////// //// //// ////////   ////
                   ///////  /////// /// /// ///////  //////
                    /////////  ////  // // ////   ////////
                       ////////  ///       //  /////////
                         ...........       ..........
                        //////////          ///////////
                         //////                //////
"
}

function checkEFI()
{
	sudo diskutil mount /dev/disk0s1
	DIR=/Volumes/EFI/EFI/CLOVER
	if [ ! -d "$DIR" ]; then
        echo "CLOVER files not found, please make sure to:"
        echo "1. Mount your EFI partition"
        echo "2. Rename your EFI partition to ""EFI"""
		exit
	else 
		echo "CLOVER files found"
    fi
}

function checkFiles()
{
    DIRECTORY=`dirname $0`
    cd $DIRECTORY
    DIR=./CLOVER
    if [ -d "$DIR" ]; then
        copyFiles
    else
        echo "Github CLOVER files not found in current directory"
        cd ~/Downloads
        DIR=./MatebookXPro-hackintosh-master/CLOVER
        if [ -d "$DIR" ]; then
            echo "Github files found in /Downloads"
            cd ~/Downloads/MatebookXPro-hackintosh-master
            copyFiles
        else
            echo "Github files not found in /Downloads"
            echo "Please download the Github files to the current directory or /Downloads"
        fi
    fi
}

function copyFiles()
{
    cp -R ./CLOVER/ /Volumes/EFI/EFI/CLOVER/
    echo "Done copying files"
    return
}

function disableHibernation()
{
    sudo pmset -a hibernatemode 0
    sudo rm /var/vm/sleepimage
    sudo mkdir /var/vm/sleepimage
    sudo pmset -a standby 0
    sudo pmset -a autopoweroff 0

}

function restart()
{
    echo "----------------------"
    echo "**** Restart Now? ****"
    echo "----------------------"
    read -p "Type y/n : " lfm_selection
    case "${lfm_selection}" in
    y)
    sudo reboot
    exit
    ;;

    n)
    echo "Please help a broke student out please :)"
    echo "Thank you! Have a great day!"
    sleep 3
    open .//Help\ a\ Broke\ Student\ out/paypal.png
    open .//Help\ a\ Broke\ Student\ out/venmo.jpg
    exit
    ;;

    *)
    echo "Please press y or n lol"
    echo "Exiting"
    sleep 1
    exit

;;
esac
}

function main()
{
    logo
    disableHibernation
	checkEFI
    checkFiles
    restart
}

main
