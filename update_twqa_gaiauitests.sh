#!/bin/bash
# Program:
#       This program is intended to update the gaia-ui-tests from Mozilla/gaia-ui-tests
#
# History:
# 2013/05/03    Walter Chen     Added some log information to go with crontab
# 2013/05/02	Walter Chen	Created this file

echo "Started to synchronize TW-QA gaia-ui-tests"

date

test -d ${1}
if [ $? == 1 ]; then
    echo "You haven't clone it yet. Now doing clone"
    git clone https://github.com/Mozilla-TWQA/gaia-ui-tests.git ${1}
fi

cd ${1}
git pull --rebase mozilla-gaiauitests master
git remote set-url origin git@github.com:Mozilla-TWQA/gaia-ui-tests.git
git push

echo "Finished synchronizing TW-QA gaia-ui-tests"
