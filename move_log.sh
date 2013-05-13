Previous_Log="/home/ypwalter/log/crontab.log"
Timestamp=$(date +"%Y%m%d%H%M")

echo "Started to move log by strange way"

# rename crontab log to another file
mv $Previous_Log $Previous_Log$Timestamp

echo -e "Finished to move log by strange way\n"

