#!/bin/bash
# clear screen
clear;

# Get current directory, assume this script is locate under Magento root directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SOURCEDIR="$DIR/media/*"
DESTDIR=/your/storage/path/media

LOGFILE="$DIR/var/log/mediasync.log"

# If backup directory not exist
test -d "$DESTDIR" || mkdir -p "$DESTDIR"

# Create log directory
test -d "$DIR/var/log" || mkdir -p "$DIR/var/log"

# Perform rsync without delete
# --log-file=rsync.log
NOW=$(date +"%b %d, %Y %H:%M:%S")
echo "------------------------------------------------"$'\r' >> $LOGFILE
echo "Media: Sync performed at $NOW" >> $LOGFILE
echo "------------------------------------------------"$'\r' >> $LOGFILE
rsync -ardv --log-file=$LOGFILE $SOURCEDIR $DESTDIR
echo "<-------------SYNC END------------->"$'\r\r\r' >> $LOGFILE
