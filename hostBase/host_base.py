import http.server
import socketserver
import sys
import os

port = 8000  #set 8000 as default serving port
if len(sys.argv) > 1:
    port = int(sys.argv[1]) #Get first argument as port if exists

if len(sys.argv) > 2:
    os.chdir(sys.argv[2]) #Get second argument as directory which has to be served

handler = http.server.SimpleHTTPRequestHandler
httpd = socketserver.TCPServer(("",port), handler)
print("serving",os.getcwd(), "at port :", port,)

try:
    httpd.serve_forever()

except KeyboardInterrupt as exception:
    print('closing server..')
    httpd.server_close()