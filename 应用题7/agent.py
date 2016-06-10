# __*__coding:utf-8__*__
import socket
import sys
#被控制端的ip及端口
#server_address = ('ip',port)
server_address = ('localhost', 11111)

# Create a TCP/IP socket
socks = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect the socket to the port where the server is listening
print >>sys.stderr, 'connecting to %s port %s' % server_address
#for s in socks:
socks.connect(server_address)
while True:
    #输入命令
    commands=raw_input('Commands(exit):')
    if commands == 'exit':
        exit(0)
    # Send messages on both sockets
    #for s in socks:
    socks.send(commands)
    
        # Read responses on both sockets
    #for s in socks:
    data = socks.recv(1024)
    print data
    if not data:
        socks.close()
    
