#!/usr/local/bin/python2.7
# __*__coding:utf-8__*__
import commands
import re
value = commands.getoutput('ifconfig')
dict1 = {}
Net_Name = re.findall('^(.*?) Link.*?', value, re.MULTILINE)
Ip_Net = re.findall('inet addr:(.*?) ', value, re.S)
#print Net_Name
#print Ip_Net
L = len(Net_Name)
for i in range(L):
    dict1[Net_Name[i]] = Ip_Net[i]
print dict1
