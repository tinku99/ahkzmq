gosub zmqconstants
libzmq := dllcall("LoadLibrary", "str", A_ScriptDir "\libzmq.dll")
context := dllcall("libzmq\zmq_init", "int", 1, "cdecl ptr")                              
tooltip, % "Connecting to hello world server…"   
requester := dllcall("libzmq\zmq_socket", "Ptr", context, "int", ZMQ_REQ, "cdecl Ptr")
hr := dllcall("libzmq\zmq_connect", "Ptr", requester, "astr", "tcp://localhost:5555", "cdecl int")
assert(hr)
VarSetCapacity(request, 16, 0)
hr := dllcall("libzmq\zmq_msg_init_size", "Ptr", &request, "uint", 5, "cdecl int")
assert(hr)
msgp := dllcall("libzmq\zmq_msg_data", "Ptr", &request, "cdecl Ptr")        
strput("Hello", msgp, 5, "utf-8")
tooltip % "Sending Hello "
hr := dllcall("libzmq\zmq_send", "Ptr", requester, "Ptr", &request, "int", 0, "cdecl int")
assert(hr)
hr := dllcall("libzmq\zmq_msg_close", "Ptr", &request, "cdecl int")
assert(hr)
VarSetCapacity(reply, 16, 0)
hr := dllcall("libzmq\zmq_msg_init", "Ptr", &reply, "cdecl int")
assert(hr)
hr := dllcall("libzmq\zmq_recv", "Ptr", requester, "Ptr", &reply, "int", 0, "cdecl int")
assert(hr)
size := dllcall("libzmq\zmq_msg_size", "Ptr", &reply, "cdecl uint")
msgp := dllcall("libzmq\zmq_msg_data", "Ptr", &reply, "cdecl Ptr")        
msg := StrGet(msgp, 5, "utf-8")       
hr := dllcall("libzmq\zmq_msg_close", "Ptr", &reply, "cdecl int")
hr := dllcall("libzmq\zmq_close", "Ptr", requester, "cdecl int")
hr := dllcall("libzmq\zmq_term", "Ptr", context, "cdecl int")                                      
tooltip, % "Received " msg " of size: " size                
listvars                                     
msgbox                                       
return                                       
!r::reload                                   
!q::exitapp                                  
assert(hr){
if hr
msgbox % "error: " hr
}                
zmqconstants:   
ZMQ_PAIR := 0
ZMQ_PUB := 1
ZMQ_SUB := 2
ZMQ_REQ := 3
ZMQ_REP := 4
ZMQ_DEALER := 5
ZMQ_ROUTER := 6
ZMQ_PULL := 7
ZMQ_PUSH := 8
ZMQ_XPUB := 9
ZMQ_XSUB := 10

return
