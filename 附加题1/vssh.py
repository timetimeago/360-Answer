# __*__coding:utf-8__*__
import commands
import sys
import re
import os
Flag = True
IP_List = []
#生成IP列表
def IP_LIST():
    IP = raw_input('Ip address:')
    IP_List = IP.split(' ')
    return IP_List
#检测IP是否正常
def IP_check(IP):
    try:
        if re.search('(\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4})', IP, re.MULTILINE).group(0):
            flag = 'true'
    except AttributeError:
        flag = 'false'
    if flag == 'true' :
        return IP
    else:
        print "%s is incorrect"%IP
def Do_Command(Command,IP):
    #执行命令
    status, Value = commands.getstatusoutput("echo '%s'|ssh '%s' 2>>/dev/null"%(Command,IP))
    #生成日志文件
    value = os.system("echo 'IP:%s'-Command:%s-`date +%%T`>> vssh-`date +%%y-%%m-%%d`.log"%(IP,Command))
    if status != 0 :
        print >>sys.stderr,':Error',status
    else:
        print Value
def Read_IP_List():
    IP =[]
    with open('IP_config','r') as F:
        IP = F.read().split('\n')
    return IP
if __name__ == '__main__':
    IP_List = []
    #IP 列表的获取方式
    choice = raw_input('choose Input IP(s) or get IP(s) from IP_config(I/R):')
    if choice == 'I':
    #手动输入IP
        IP_list = IP_LIST()
    elif choice == 'R':
    #从文件列表获取
        IP_list = Read_IP_List()
    else:
        print >>sys.stderr,'Usage:Input ip or Read ip'
        exit(1)
    #返回规范的IP列表
    IP_List = map(IP_check, IP_list)
    Command = raw_input('Input command(exit):')
    if Command == 'exit':
        exit(0)
    #SSH到各个服务器，执行命令
    while True:
        for i in IP_List:
            Do_Command(Command,i)
#         map(Do_Command,IP_List)