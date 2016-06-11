# __*__coding:utf-8__*__
import select
import socket
import sys
import Queue
import commands
#建立socket对象，初始化
server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server.setblocking(0)
#server_address = ('ip',port)
server_address = ('localhost',11111)
server.bind(server_address)
server.listen(5)
inputs = [ server ]
outputs = [ ]
message_queues = {}
while inputs:
    #通过select 函数监测活动链接
    Rec,Send,error = select.select(inputs, outputs, inputs)
    #逐个获取活动链接的Socket对象
    for s in Rec:
        #监测是否为新链接
        if s is server:
            connection, client_address = s.accept()
            connection.setblocking(0)
            inputs.append(connection)
            message_queues[connection] = Queue.Queue()
        else:
            data = s.recv(1024)
            if data:
                message_queues[s].put(data)
                if s not in outputs:
                    outputs.append(s)
            else:
                if s in outputs:
                    outputs.remove(s)
                inputs.remove(s)
                s.close()
                del message_queues[s]
    #开始发送
    for s in Send:
        try:
            command = message_queues[s].get_nowait()
        except Queue.Empty:
            outputs.remove(s)
        else:
            next_msg=commands.getoutput(command)
            s.send(next_msg)
    #错误链接处理
    for s in error:
        inputs.remove(s)
        if s in outputs:
            outputs.remove(s)
        s.close()
        del message_queues[s]        