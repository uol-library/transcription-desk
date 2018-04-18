#!/bin/bash

# Backup of MySQL database
# Most recent backup is in <db>.Backup.gz
# Other 6 (compressed) backups are rotated in <db>.Backup.1 - .6

set -eu
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/setVars.sh

function usage {
    echo
    echo $BFILE is used to perform regular backup dumps of a MySQL database:
    echo
    echo 1. Does a mysqldump of entire database
    echo
    echo "$BFILE <database> [user]"
    echo 
    echo Supply user if this is different from the database name
    echo
    echo e.g. $BFILE lib18
    echo
    exit 1
}

# get password

#pass=`grep DB_PASSWORD $LULHOME/var/database.ini | perl  -n -e '/DB_PASSWORD\s=\s"(.+)"/; print $1;'`

# Backup dump


BFILE=`basename $0`
date
hostname

# Check that there is a database

if [ "$#" -eq 0 ]; then
    usage
    exit 1
fi

for dbloop in "${LULDATABASES[@]}"
do
    if [ "$1" == "$dbloop" ]; then
        db=$dbloop
        cnf=".my.cnf.$1"
    fi
done

if [ ! $db ]; then
    echo ERROR - invalid database supplied
    exit 1
fi


# Change directory

echo Backing up $db
cd $LULSYSTEMSDIR/Dumps/$db


# Rotate old backups

for ((i=$LULDATABASENUMBER;i>=2;i--))
do
    let j=$i-1
    if [ -f $db.Backup.$j.gz ]; then
        /bin/mv -f $db.Backup.$j.gz $db.Backup.$i.gz > /dev/null 2>&1
    fi
done
    if [ -f $db.Backup.gz ]; then
        /bin/mv -f $db.Backup.gz $db.Backup.1.gz > /dev/null 2>&1
    fi


# Do new dump and gzip

/usr/bin/mysqldump --defaults-file=$LULDATABASECONFDIR/$cnf --lock-tables=false $db > $db.Backup
/bin/gzip $db.Backup # > /dev/null 2>&1
ls -lt

exit
