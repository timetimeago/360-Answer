# __*__coding:utf-8__*__
import socket
import Queue
import select
server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
addre = ('localhost',11111)
server.bind(addre)
server.setblocking(0)
server.listen(5)
#初始化 连接表，收信表,及发送信息表
Var = [ server ]
Send = []
error = []
msg_que = {}
#定义Key-Value信息
ttt = {}
ttt['foo'] = 2014
Flag = True
while Var:
    Rec,Send,error = select.select(Var, Send, error)
    for i in Rec:
        if i is server:
            con,ip = i.accept()
            Var.append(con)
            msg_que[con] = Queue.Queue()
        else:
            data = i.recv(1024)
            if data == 'exit':
                continue
            if data:
                msg_que[i].put(data)
                if i not in Send:
                    Send.append(i)
            else:
                if i in Send:
                    Send.remove(i)
                Var.remove(i)
                i.close()
                del msg_que[i]
    for i in Send:
        try:
            key = msg_que[i].get_nowait()
        except Queue.Empty:
            Send.remove(i)
        else:
            try:
                value= ttt[key]
            except KeyError,e:
                value = "The value is not defined"
            i.send(str(value))