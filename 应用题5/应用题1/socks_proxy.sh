#!/bin/sh
echo -e "警告:请在远端服务器创建秘钥，并将公钥拷贝到本地端\n如以进行该操作。请忽视本条消息"
ssh -NfR $Home_Port:$remote_IP:$remote_Port $Home_IP
    


