#!/bin/sh
#Main shell
#设置搜寻CPU的时间 example 08:08:08
#如果想一天多次查找，例如 08:08:08 和 10:10:10
#那么 Time_set=("08:08:08" "10:10:10")
Time_set=("13:12:01" "13:12:10")
#一个月分割一次查询记录
This_month=`date +%Y-%m`
export filename="CPUinfo_$This_month.log"
while (true)
do
    this_time=`date +%T`
    for Times in ${Time_set[*]}
    do
#        echo $Times
        if [ "$this_time" == "$Times" ]
        then
            . sysinfo_recorder.sh &
            sleep 1s
        fi
    done
done
