import zmq
import time
import sys

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

while True:
    #  Wait for next request from client
    message = socket.recv()
    print("Received request: ", message)
    sys.stdout.flush()
    socket.send(b"World")


