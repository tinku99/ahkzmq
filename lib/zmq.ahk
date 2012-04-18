class zmq {
static ZMQ_PAIR := 0 
static ZMQ_PUB := 1  
static ZMQ_SUB := 2  
static ZMQ_REQ := 3  
static ZMQ_REP := 4  
static ZMQ_DEALER := 5
static ZMQ_ROUTER := 6
static ZMQ_PULL := 7 
static ZMQ_PUSH := 8 
static ZMQ_XPUB := 9 
static ZMQ_XSUB := 10
static ZMQ_HWM := 1
static ZMQ_SWAP := 3
static ZMQ_AFFINITY := 4
static ZMQ_IDENTITY := 5
static ZMQ_SUBSCRIBE := 6
static ZMQ_UNSUBSCRIBE := 7
static ZMQ_RATE := 8
static ZMQ_RECOVERY_IVL := 9
static ZMQ_MCAST_LOOP := 10
static ZMQ_SNDBUF := 11
static ZMQ_RCVBUF := 12
static ZMQ_RCVMORE := 13
static ZMQ_FD := 14
static ZMQ_EVENTS := 15
static ZMQ_TYPE := 16
static ZMQ_LINGER := 17
static ZMQ_RECONNECT_IVL := 18
static ZMQ_BACKLOG := 19
static ZMQ_RECOVERY_IVL_MSEC := 20
static ZMQ_RECONNECT_IVL_MAX := 21
static ZMQ_NOBLOCK := 1
static ZMQ_SNDMORE := 2
static ZMQ_POLLIN := 1
static ZMQ_POLLOUT := 2
static ZMQ_POLLERR := 4
static ZMQ_STREAMER := 1
static ZMQ_FORWARDER := 2
static ZMQ_QUEUE := 3
      

   __New(){
EnvGet, path, PATH  			       			   
EnvSet, PATH, % ";" A_ScriptDir 
libzmq := dllcall("LoadLibrary", "str", A_ScriptDir "\libzmq.dll")
if !libzmq{                                     
throw "error loading " file
} 
this.__handle := libzmq
}
__call(func, args*) {
        types := this[func].arg_types
            loop % types.maxindex() 
                args.insert((A_Index<<1)-1, types[A_Index])
            args.insert("cdecl " this[func].returntype)
            ; msgbox % tostring(args)
        return DllCall("libzmq\" func, args*)      
    }                                  
static zmq_msg_init := {arg_types: ["Ptr"], returntype : "int"}
static zmq_msg_init_size := {arg_types: ["Ptr", "uint"], returntype : "int"} 
static zmq_msg_init_data := {arg_types: ["Ptr", "Ptr", "uint"
, "Ptr", "Ptr"], returntype : "int"}
static zmq_msg_close := {arg_types: ["Ptr"], returntype : "int"}
static zmq_msg_move := {arg_types: ["Ptr", "Ptr"], returntype : "int"}
static zmq_msg_copy := {arg_types: ["Ptr", "Ptr"], returntype : "int"}
static zmq_msg_data := {arg_types: ["Ptr"], returntype : "Ptr"}
static zmq_msg_size := {arg_types: ["Ptr"], returntype : "uint"}
                           
static zmq_init := {arg_types: ["int"], returntype: "Ptr"} 
static zmq_term := {arg_types: ["Ptr"], returntype: "int"}    
static zmq_socket := {arg_types: ["Ptr", "int"], returntype: "Ptr"}                     
static zmq_close := {arg_types: ["Ptr"], returntype: "int"}                                        
static zmq_setsockopt := {arg_types: ["Ptr", "int"
,  "Ptr", "Ptr"], returntype: "int"}                         
static zmq_getsockopt := {arg_types: ["Ptr", "int"
, "Ptr", "Ptr"], returntype: "int"} 
static zmq_bind := {arg_types: ["Ptr",  "astr"], returntype: "int"}                       
static zmq_connect := {arg_types: ["Ptr", "astr"], returntype: "int"}                    
static zmq_send := {arg_types: ["Ptr", "Ptr", "int"], returntype: "int"}              
static zmq_recv := {arg_types: ["Ptr", "Ptr", "int"], returntype: "int"}              
static zmq_poll := {arg_types: ["Ptr", "int", "long"], returntype: "int"}
static zmq_device := {arg_types: ["int", "Ptr", "Ptr"], returntype: "int"}
static zmq_errno := {arg_types: [], returntype: "int"}
static zmq_strerror := {arg_types: ["int"], returntype: "astr"}
}
