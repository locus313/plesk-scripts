#!/bin/sh
HOME=/backup/mysql/
export HOME
FOLDER=/backup/mysql/data
PID=/backup/mysql/mysql.pid

/bin/mkdir -p "$FOLDER"
rm -Rf "$FOLDER/*"

if [ -f $PID ]
then

KILL=`cat $PID`

echo "Another instance of script is run trying to kill:" `kill -9 $KILL`

fi

echo $$ > $PID

umask 077

IFS=''
/usr/sbin/plesk db -e "show databases" | grep -v -E "^Database|information_schema|performance_schema|phpmyadmin" > $FOLDER/dbs.txt

if [ "x$?" != "x0" ]; then
  echo cannot connect to MySQL
  rm -f $PID
  exit 1
fi

echo "Dumping mysql: "

for i in `cat $FOLDER/dbs.txt`;
do
        echo "$i"
        /usr/sbin/plesk db dump "$i" > $FOLDER/"$i".sql
        
        if [ "x$?" != "x0" ]; then
                echo "Dump fialed for db: $i"
        fi

done

echo "mysql backup done"

rm -f $PID

exit 0
