#singleinstance off	
z := zstart("tcp://localhost:5555")
omsg := ["what", "else"]
zsendrcv(z, omsg)
return

f2::
zsendrcv(z, omsg)
return
;; zsendrcv(z, omsg)
zsendrcv(z, omsg){
  VarSetCapacity(request, 16, 0)                      
  VarSetCapacity(reply, 16, 0)
if !omsg	   
  omsg := ["hello", "world"]		       	    			   
msg := json_to(omsg)	
hr := z.zmq_msg_init_size(&request, strlen(msg))
assert(hr)                          
msgp := z.zmq_msg_data(&request)    
strput(msg, msgp, strlen(msg) , "utf-8")
tooltip % "Sending`n" msg     	
hr := z.zmq_send(z.requester, &request, 0)
assert(hr)                            
hr := z.zmq_msg_close(&request)
assert(hr)                   
hr := z.zmq_msg_init(&reply)
assert(hr)                
hr := z.zmq_recv(z.requester, &reply, 0)
assert(hr)                          
size := z.zmq_msg_size(&reply)
msgp := z.zmq_msg_data(&reply)        
msg := StrGet(msgp, size, "utf-8")       
hr := z.zmq_msg_close(&reply)
 ;  tooltip, % "Received " msg " of size: " size                
jmsg := json_from(msg)	
tooltip % tostring(jmsg)
return jmsg    
}      	 
;; ztart()
zstart(endpoint="tcp://localhost:5555"){	
z := new zmq()			    
z.context := z.zmq_init(1)	    
tooltip, % "Connecting to " endpoint   
z.requester := z.zmq_socket(z.context, z.ZMQ_REQ)
hr := z.zmq_connect(z.requester, endpoint)
assert(hr)	    
return z                                          
}
;; hotkeys                                  
!r::
hr := z.zmq_close(z.requester)
hr := z.zmq_term(z.context)                                      
reload                                   

!q::
hr := z.zmq_close(z.requester)
hr := z.zmq_term(z.context)                                      
exitapp

;; assert(hr)                                  
assert(hr){                       
if ErrorLevel{
listlines
msgbox % ErrorLevel
}
if hr                             
msgbox % "error: " hr             
}                
return
;; includes
#include lib\zmq.ahk
#include lib\json.ahk
