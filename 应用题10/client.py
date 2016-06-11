# __*__coding:utf-8__*__
import socket
cli = socket.socket()
ip= ('localhost',11111)
cli.connect(ip)
while True:
    var = raw_input('input a key(exit):')
    cli.send(str(var))
    if var == 'exit':
        break
    value = cli.recv(1024)
    print value
cli.close()
exit(0)