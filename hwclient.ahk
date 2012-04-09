z := new zmq()
msgbox % z.__handle "`n" z.ZMQ_REQ
context := z.zmq_init(1)
tooltip, % "Connecting to hello world server…"   
requester := z.zmq_socket(context, z.ZMQ_REQ)
     
hr := z.zmq_connect(requester, "tcp://localhost:5555")
assert(hr)                                          
VarSetCapacity(request, 16, 0)                      
hr := z.zmq_msg_init_size(&request, 5)
assert(hr)                         
msgp := z.zmq_msg_data(&request)
strput("Hello", msgp, 5, "utf-8")
tooltip % "Sending Hello "   
hr := z.zmq_send(requester, &request, 0)
assert(hr)                            
hr := z.zmq_msg_close(&request)
assert(hr)                   
VarSetCapacity(reply, 16, 0)
hr := z.zmq_msg_init(&reply)
assert(hr)                
hr := z.zmq_recv(requester, &reply, 0)
assert(hr)                          
size := z.zmq_msg_size(&reply)
msgp := z.zmq_msg_data(&reply)        
msg := StrGet(msgp, 5, "utf-8")       
hr := z.zmq_msg_close(&reply)
hr := z.zmq_close(requester)
hr := z.zmq_term(context)                                      
tooltip, % "Received " msg " of size: " size                
listvars                                     
msgbox                                       
return                                       
!r::reload                                   
!q::exitapp                                  
assert(hr){                       
if ErrorLevel{
listlines
msgbox % ErrorLevel
}
if hr                             
msgbox % "error: " hr             
}                
return

#include lib\zmq.ahk
