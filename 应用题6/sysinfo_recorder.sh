#!/bin/sh
#total CPU numbers CPu总数
Cpu_Num=`cat /proc/cpuinfo|grep -w processor|wc -l`
#All CPU working status  各个Cpu的利用率
Tota="$(sar -P ALL 1 1|awk '{if ($1 == "Average:") print $2" "$3" "$4" "$5" "$6" "$7" "$8}')"
#Average Cpu utilization  cpu的平均利用率
Cpu_uti=$(echo -e "$Tota"|grep all|awk '{print $3}')
#Uptime  负载
UpTime=$(uptime |awk '{print $10 $11 $12}')
#the first fives of  progress Cpu 按照%CPU%排名前五的。
Uti_P_5=$(top -b -n 1|awk '{if (NR >7) print $9" "$12}'|awk '{a[$2]+=$1;}END{for(i in a) print i" "a[i]}'|sort -n -r -k2 -n|head -n 5)
#the first fives of  progress Cpu 按照%Time%排序前五的。
Time_P_5=$(top -b -n 1|awk '{if (NR >7) print $11" "$12}'|awk '{a[$2]+=$1;}END{for(i in a) print i" "a[i]}'|sort -n -r -k2 -n|head -n 5)
#写入文件
Time=`date +%T`
Date=`date +%D`
echo -e "时间:$Date - $Time" >>"$filename"
echo -e "CPU总数 - $Cpu_Num" >>"$filename"
echo -e "各个CPU的使用详情:\n$Cpu_uti" >>"$filename"
echo -e "负载:$UpTime" >>"$filename"
echo -e "CPU利用率高的前五个:\n$Uti_P_5" >>"$filename"
echo -e "占用时间片长的前五个:\n$Time_P_5" >>"$filename"


















