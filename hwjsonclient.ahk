z := new zmq()
context := z.zmq_init(1)
tooltip, % "Connecting to hello world server…"   
requester := z.zmq_socket(context, z.ZMQ_REQ)
     
hr := z.zmq_connect(requester, "tcp://localhost:5555")
assert(hr)                                          
VarSetCapacity(request, 16, 0)                      
omsg := ["hello", "world"]		       	    			   
msg := json_to(omsg)	
hr := z.zmq_msg_init_size(&request, strlen(msg))
assert(hr)                          
msgp := z.zmq_msg_data(&request)    
strput(msg, msgp, strlen(msg) , "utf-8")
tooltip % "Sending`n" msg     	
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
msg := StrGet(msgp, size, "utf-8")       
hr := z.zmq_msg_close(&reply)
hr := z.zmq_close(requester)
hr := z.zmq_term(context)                                      
msgbox, % "Received " msg " of size: " size                
jmsg := json_from(msg)
msgbox % tostring(jmsg)
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
#include lib\json.ahk
