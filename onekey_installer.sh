function networkWarning()
{
    echo "ERROR: Fail to download GitHub Files, please check your Internet connection!"
    sleep 3
    exit
}

function downloadFiles()
{
    cd
    cd Downloads
    echo "------------------------------------------------------"
    echo "--| Downloading GitHub files into Downloads folder |--"
    echo "------------------------------------------------------"
    curl -L -O "https://github.com/gnodipac886/MatebookXPro-hackintosh/archive/6.1.zip" || networkWarn
    echo "Download Complete"
    sleep 1
    echo "Unzipping Files"
    unzip -qu "6.1"
    echo "Files unzipped"
    echo "Now running autoinstallation script..."
    sleep 1
}

function runScript()
{
    echo "----------------------"
    echo "**** Install Now? ****"
    echo "----------------------"
    read -p "Type y/n : " lfm_selection
    case "${lfm_selection}" in
    y)
    cd
    cd Downloads/MatebookXPro-hackintosh-6.1
    ./autoinstaller.command
    ;;

    n)
    cd
    cd Downloads/MatebookXPro-hackintosh-6.1
    echo "Please help a broke student out please :)"
    echo "Thank you! Have a great day!"
    sleep 3
    open Help\ a\ Broke\ Student\ out/paypal.png
    open Help\ a\ Broke\ Student\ out/venmo.jpg
    exit
    ;;

    *)
    echo "Please press y or n lol"
    echo "Exiting"
    sleep 1
    exit
    esac
}
function main()
{
    downloadFiles
    sleep 2
    runScript
    sleep 2
}

main
