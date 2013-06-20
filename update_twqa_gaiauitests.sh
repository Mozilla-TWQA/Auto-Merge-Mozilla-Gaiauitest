#!/bin/bash
# Program:
#       This program is intended to update the gaia-ui-tests from Mozilla/gaia-ui-tests
#
# History:
# 2013/05/14    Walter Chen     Modified it to do auto clone if folder not existed
# 2013/05/03    Walter Chen     Added some log information to go with crontab
# 2013/05/02	Walter Chen	Created this file

# helper_config function
function helper_config(){
    echo -e "The config file error."
    echo -e "\tfilename: .auto_update_gaiatest.conf"
    echo -e "\t===== File Content ====="
    echo -e "\tBranches=master;v1-train;v1.0.1"
    echo -e "\t========================"
}

echo "Started to synchronize TW-QA gaia-ui-tests"

date

#############################################
# Load Config File (before load parameters) #
#############################################

CONFIG_FILE=.auto_update_gaiatest.conf
if [ -f $CONFIG_FILE ]; then
    . $CONFIG_FILE
else
    helper_config
    exit -2
fi
if [ -z $Branches ]; then
    helper_config
    exit -2
fi


#############################################
# Pull New Codes From Mozilla Gaia-ui-test  #
#############################################

# see if the folder exists
test -d ${1}
if [ $? == 1 ]; then
    echo "You haven't clone it yet. Now doing clone"
    git clone https://github.com/Mozilla-TWQA/gaia-ui-tests.git ${1}
fi

cd ${1}

# add mozilla gaia-ui-tests remote
if [ $(git remote show | grep mozilla-gaiauitests -c) == 1 ]; then
    git remote rm mozilla-gaiauitests
fi
git remote add mozilla-gaiauitests https://github.com/mozilla/gaia-ui-tests.git

for branch in $Branches; do
    # update the branch
    git checkout $branch
    git pull --rebase mozilla-gaiauitests $branch
    git remote set-url origin git@github.com:Mozilla-TWQA/gaia-ui-tests.git
    git push

    # update the matching tw-modified branch
    branch_to_update=tw-modified-${branch}
    if [ $(git branch | grep tw-modified-master -c) == 1 ]; then
        git branch -D $branch_to_update
    fi
    git branch $branch_to_update
    git checkout $branch_to_update
    git pull origin $branch_to_update
    git pull --rebase origin $branch
    git remote set-url origin git@github.com:Mozilla-TWQA/gaia-ui-tests.git
    git push
done

echo "Finished synchronizing TW-QA gaia-ui-tests"
