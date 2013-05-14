# You need to set this default script location
Script_Location=$(pwd)

Gaia_Ui_Test_Folder="${Script_Location}/twqa-gaia-ui-tests/"
Previous_Log="${Script_Location}/log/crontab.log"
Timestamp=$(date +"%Y%m%d%H%M")

${Script_Location}/move_log.sh ${Previous_Log}
${Script_Location}/update_twqa_gaiauitests.sh ${Gaia_Ui_Test_Folder}
