#!/bin/bash
# clear screen
clear;
# Note: Placed this script under shop root director
# check if any action argument passed
if [ "$1" == "" ]; then
    printf "\e[0;31m%s\e[m\nPossible args is: \n\e[1;32m+i\e[m\e[0;33m%s\e[m \n\e[1;31m-i\e[m\e[0;33m%s\e[m\n" "Error:: Action argument is missing!" '[For applying immutable flag]' '[For removing immutable flag]'
    exit 1
elif [ "$1" != '+i' -a "$1" != '-i' ]; then
    printf "\e[0;31m%s\e[m\nPossible args is: \n\e[1;32m+i\e[m\e[0;33m%s\e[m \n\e[1;31m-i\e[m\e[0;33m%s\e[m\n" "Error:: Invalid action!" '[For applying immutable flag]' '[For removing immutable flag]'
    exit 1
else
# Get action type
ACTION="$1"
`find . -type f -name "*.*" -not -name "*.txt" ! -path "./media*" ! -path "./var*" -exec chattr $ACTION {} \;`
`find . -type d ! -path "./media*" ! -path "./var*" -exec chattr $ACTION {} \;`

#LOG FILE PATH
LOGFILE="var/log/file_attribute_update.log"

#CURRENT DATETIME
NOW=$(date +"%b %d, %Y %H:%M:%S")

# CREATE LOG FILE
touch $LOGFILE

echo "------------------------------------------------"$'\r' >> $LOGFILE
echo "File attribute updated at $NOW" >> $LOGFILE
echo "------------------------------------------------"$'\r' >> $LOGFILE
echo "Action performed:: chattr $ACTION"$'\r' >> $LOGFILE
echo "User Login Details::"$'\r' >> $LOGFILE
pinky >> $LOGFILE
echo $'\r' >> $LOGFILE
echo "------------------------------------------------"$'\r\r\r' >> $LOGFILE
printf "\e[1;32m%s\e[m\n" "Success:: File Attribute Updated!"
fi
