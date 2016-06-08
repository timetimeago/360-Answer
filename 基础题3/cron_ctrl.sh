#!/bin/sh
Job=$1
Act=$2
#judge arguments
if [ "$#" != 2 ]
then
    echo "Usage:Jobname and (--start/stop/list)"
    exit 1
fi
#Find Job in crontab
grep -w "$Job" /etc/crontab>>/dev/null
if [ "$?" -ne 0 ]
then
    echo "The Job isn't exists"
    exit 1
fi
#Action
#judge Job's State
state=`grep $Job /etc/crontab|tr -s ' '|cut -c1`
if [ "$state" == " " ]
then
    state=`grep $Job /etc/crontab|tr -s ' '|cut -c2`
fi
#start  Action
if [ "$Act" == "--start" ]
then
    if [ "$state" == "#" ]
    then
        sed -i "s/#\(.*$Job.*$\)/\1/g" /etc/crontab
        if [ $? -ne 0 ]
        then
           echo "Start Error"
           exit 1
        fi
        echo "$Job is UP"
    else
        echo "$Job already Opened"
    fi
#stop Action
elif [ "$Act" == "--stop" ]
then
    if [ "$state" != "#" ]
    then
        sed -i "s/^\(.*$Job.*$\)/#\1/g" /etc/crontab
        if [ $? -ne 0 ]
        then
           echo "Start Error"
           exit 1
        fi

        echo "$Job is closed"
    else
        echo "$Job already closed"
    fi
#list Action
elif [ "$Act" == "--list" ]
then
    JobDeta=`grep $Job /etc/crontab`
    echo "$JobDeta"
fi
