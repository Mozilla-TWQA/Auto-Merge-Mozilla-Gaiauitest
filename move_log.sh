echo "Started to move log by strange way"

# get current time
Timestamp=$(date +"%Y%m%d%H%M")

# rename crontab log to another file
mv $1 $1$Timestamp

echo -e "Finished to move log by strange way\n"

