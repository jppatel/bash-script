#!/bin/bash
# clear screen
clear;

# Get current directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SOURCEDIR="$DIR/tmp/*" # This will be you current directory in which this file is placed. For e.g. if you placed this file under /var/www/html/, then $DIR contains same path
LOGFILE="$DIR/log/deletedfile.log"

# Create log directory
test -d "$DIR/log" || mkdir -p "$DIR/log" # Create log directory 

# Perform recursive files delete which is older than 540 minutes
NOW=$(date +"%b %d, %Y %H:%M:%S")
echo "------------------------------------------------"$'\r' >> $LOGFILE
echo "Files: Deleted process performed at $NOW" >> $LOGFILE
echo "------------------------------------------------"$'\r' >> $LOGFILE
#find . -mmin +540 -type f -print >> $LOGFILE
find . -mmin +540 -type f -print -delete >> $LOGFILE
find . -type d -empty -print -delete >> $LOGFILE
echo "<-------------SYNC END------------->"$'\r\r\r' >> $LOGFILE
