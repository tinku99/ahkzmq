import zmq
import time

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")
 
while True:
    #  Wait for next request from client
    message = socket.recv_json()
    print "Received request: ", message
                         
    socket.send_json({"count": 2, 1: "echo" , 2: " from server"})
 
 
