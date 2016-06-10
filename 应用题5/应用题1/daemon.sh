#!/bin/sh
#socks_proxy.sh daemon
Process="socks_proxy.sh"
#remote_IP 是需要代理的远端地址
#remote_Port 是需要代理的远端端口
#Home_IP 需要代理到哪个地方
#Home_Port 需要代理到哪个端口
export remote_IP="192.168.150.129"
export remote_Port=22
export Home_IP="192.168.150.130"
export Home_Port=8000
while true
do
    #进程崩溃检测
    state=`ps aux|grep "ssh -NfR"|grep -v 'grep'|wc -l`
    if [ $state -lt 1 ]
    then
        /bin/sh "$Process"
    fi
    #网络心跳检测
    ping $Home_IP -c4 -w1000 >>/dev/null
    if [ $? != 0 ]
    then
        ps aux|grep "ssh -NfR"|awk '{print $2}'|xargs kill -9 >>/dev/null
        /bin/sh "$Process"
    fi
done
