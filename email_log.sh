echo "Started to email the log out"

/usr/lib/sendmail -v wachen@mozilla.com < ${1}

echo "Finished emailing the log"
