#!/bin/bash
# Program:
#       This program is intended to update the gaia-ui-tests from Mozilla/gaia-ui-tests
#
# History:
# 2013/05/14    Walter Chen     Modified it to do auto clone if folder not existed
# 2013/05/03    Walter Chen     Added some log information to go with crontab
# 2013/05/02	Walter Chen	Created this file

echo "Started to synchronize TW-QA gaia-ui-tests"

date

# see if the folder exists
test -d ${1}
if [ $? == 1 ]; then
    echo "You haven't clone it yet. Now doing clone"
    git clone https://github.com/Mozilla-TWQA/gaia-ui-tests.git ${1}
fi

# update master branch
cd ${1}
if [ $(git remote show | grep mozilla-gaiauitests -c) == 1 ]; then
    git remote rm mozilla-gaiauitests
fi
git remote add mozilla-gaiauitests https://github.com/mozilla/gaia-ui-tests.git
git checkout master
git pull --rebase mozilla-gaiauitests master
git remote set-url origin git@github.com:Mozilla-TWQA/gaia-ui-tests.git
git push

# update tw-modified branch
if [ $(git branch | grep tw-modified -c) == 1 ]; then
    git branch -D tw-modified
fi
git branch tw-modified
git checkout tw-modified
git pull origin tw-modified
git pull --rebase origin master
git remote set-url origin git@github.com:Mozilla-TWQA/gaia-ui-tests.git
git push

echo "Finished synchronizing TW-QA gaia-ui-tests"
