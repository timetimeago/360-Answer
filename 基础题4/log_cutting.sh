#!/bin/sh
#You can choose Mod=1 and Mod=2,the Mod default 1
#When Mod set 1, Cutting log by time that you set
#When Mod set 2, Cutting log by Size that you set
Mod=1

#FileName
file=access.log

#set Time
#Style Hour-Min,if you would want to cut log at 00:00 every day.you could set Time="22-10"
Time="23-46"

#set Size
#When the size reached you set value,this log will be cut. Size bytes.
Size=
#When Mod set 1
while (true)
do
    Date=`date +%m-%d`
    if [ $Mod -eq 1 ]
    then
        time=`date +%H-%M`
        if [ "$Time" == "$time" ]
        then
            cp "$file" "$file-$Date"
            cat /dev/null > "$file"
            /bin/sleep 1m
        fi
#When Mod set 2
    elif [ $Mod -eq 2 ]
    then
        size=`ll $file|awk '{print $5}'`
        if [ "$Size" == "$size" ]
        then
            cp "$file" "$file-$Date"
            cat /dev/null > "$file"
        fi
    else
        echo 'Usage:set Mod 1 or 2'
        exit 1
    fi
done
