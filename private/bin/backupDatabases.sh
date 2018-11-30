# Backup actions:
#
# 1. Dumps databases
# 2. Copies dump file(s) to N drive using the rsync daemon on lib-code5

set -eu
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/setVars.sh

echo 
echo "#########################################################"
echo 

for db in  "${LULDATABASES[@]}"
do
    echo $db
    $LULSYSTEMSDIR/bin/db_backup_dump.sh $db
    rsync -lcrvt -e "ssh -p 2222" $LULDATABASEDUMPDIR/$db/${db}.Backup.gz $LULDATABASEREMOTEDIR/
done

