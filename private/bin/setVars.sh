#!/bin/bash

# Sets variables used in the Systems bin and Cron (and perhaps other) scripts

# Username of the usal LUL unix user
LULLIVEUSER=libadmin
LULTESTHOST=libprdhv
LULDEVHOST=libdevhv

# Main directory
LULHOME=/var/www/transcription
export LULHOME

LULHOST=`hostname  | cut -d '.' -f 1`
if [ $LULHOST == $LULDEVHOST ]; then
    LULX=
elif [ $LULHOST == $LULTESTHOST ]; then
    LULX=
else
    echo ERROR - INVALID HOST
    exit 1
fi

# Root directory of Systems directories
LULSYSTEMSDIR=$LULHOME/private

# Root directory of logs directory
LULLOGDIR=$LULSYSTEMSDIR/Logs

# Remote server and root directory for rsync backups
LULRSYNCREMOTESERVER="lib15.leeds.ac.uk"

# Remote server ssh port
LULRSYNCREMOTEPORT=2222

# Remote server rsync user
LULRSYNCUSER="libfold"

# Remote server conf file
LULRSYNCCONFFILE="$LULSYSTEMSDIR/bin/.rsync.conf"

# Remote server and root directory for rsync backups
LULRSYNCREMOTEDIR="$LULRSYNCUSER@$LULRSYNCREMOTESERVER:/cygdrive/c/WebSynchronisation/Systems/Databases"

# Database backup remote backup directory - for rsync
LULDATABASEREMOTEDIR="$LULRSYNCREMOTEDIR/$LULHOST"

# Database host
LULDATABASEHOST=localhost

# Datadbase dumps  direvtory
LULDATABASEDUMPDIR=$LULSYSTEMSDIR/Dumps

# Databases to backup
LULDATABASES=( wikitrans )

# Number of database backups to save
LULDATABASENUMBER=3

# Directory where the .my conf file resides
LULDATABASECONFDIR=$LULSYSTEMSDIR/bin

