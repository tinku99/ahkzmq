z := new zmq()
context := z.zmq_init(1)
responder := z.zmq_socket(context, z.ZMQ_REP)
                                           
VarSetCapacity(request, 16, 0)
VarSetCapacity(reply, 16, 0)                      

hr := z.zmq_bind(responder, "tcp://*:5555")
assert(hr)                                          
loop {
hr := z.zmq_msg_init(&request)
assert(hr)                
hr := z.zmq_recv(responder, &request, z.ZMQ_NOBLOCK)
if (hr != 0){
sleep, 200
continue 
}       
size := z.zmq_msg_size(&request)
msgp := z.zmq_msg_data(&request)        
msg := StrGet(msgp, 5, "utf-8")       
hr := z.zmq_msg_close(&request)
ToolTip, % "server: Received: " msg " of size: " size, 0, 0               
hr := z.zmq_msg_init_size(&reply, 5)
assert(hr)                         
msgp := z.zmq_msg_data(&reply)
strput("World", msgp, 5, "utf-8")
tooltip % "Sending world ", 0, 0   
hr := z.zmq_send(responder, &reply, 0)
assert(hr)                            
hr := z.zmq_msg_close(&reply)
assert(hr)                   
}         
return                                       
!r::reload                                   
!q::
hr := z.zmq_close(responder)
hr := z.zmq_term(context)
exitapp                                  
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
