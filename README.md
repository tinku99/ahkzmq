# ahkzmq
ahkzmq is an AutoHotkey_L wrapper for zeromq.

## zeromq
zeromq is a socket library that:

-  Carries messages across inproc, IPC, TCP, and multicast.
-  Connect N-to-N via fanout, pubsub, pipeline, request-reply.
-  supports interaction between 30+ languages including C, C++, Java, .NET, Python, and now **autohotkey!**

## Examples
1. rep/req example from the [zguide][1] 

```autohotkey
#singleinstance off	
z := zstart("tcp://localhost:5555")
omsg := ["hello", "from", "autohotkey"]
msg := zsendrcv(z, omsg)
loop % msg.count{
msgbox % msg[A_Index]
}

return

f2::
zsendrcv(z, omsg)
return
;; hotkeys                                  
!r::reload

!q::exitapp
  
;; includes
#include lib\zmq.ahk
#include lib\json.ahk


```
**hwjsonserver.py**
```python
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
 
```
## History
the tcp class, example from the german forum inspired
me to take another crack at zeromq in ahk. 


[1]: http://zguide.zeromq.org "zguide"
