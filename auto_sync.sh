# You need to set this default script location
Script_Location="/home/ypwalter/Autoupdate"

Gaia_Ui_Test_Folder="${Script_Location}/twqa-gaia-ui-tests/"
Log_Location="${Script_Location}/log/"
Previous_Log="${Log_Location}crontab.log"
Timestamp=$(date +"%Y%m%d%H%M")
Date=$(date +"%Y%m%d")

echo "subject:TW-QA gaia-ui-tests auto synchonization log ${Date}"
${Script_Location}/move_log.sh ${Previous_Log} ${Previous_Log}${Timestamp}
${Script_Location}/update_twqa_gaiauitests.sh ${Gaia_Ui_Test_Folder}
${Script_Location}/email_log.sh ${Previous_Log}${Timestamp}
