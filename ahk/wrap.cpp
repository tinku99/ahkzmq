#include "stdafx.h"
#include "../include/zmq.hpp"
#include <string>
#include <iostream>
#include <Windows.h>

#define EXPORT extern "C" __declspec(dllexport)
EXPORT void * acontext(){
   void *context = zmq_init (1);
return context; 
}

EXPORT void * areqsocket (void * context, const char * connectionString)
{ 
    void *requester = zmq_socket (context, ZMQ_REQ);
    int hr = zmq_connect (requester, connectionString);  // "tcp://localhost:5555"
	return requester ;
}

EXPORT int asend(void * requester, char * message, unsigned int size){
        zmq_msg_t request;
        zmq_msg_init_size (&request, size);
        memcpy (zmq_msg_data (&request), message, size);
       int hr = zmq_send (requester, &request, 0);
        zmq_msg_close (&request);
	return hr ;
}
EXPORT char * arecv(void * requester){
    static char * buffer = NULL ;     
	static size_t bufsize = 0 ;
	zmq_msg_t reply;
        zmq_msg_init (&reply);
        zmq_recv (requester, &reply, 0);
		size_t size = zmq_msg_size(&reply) ;
		if (size > bufsize){
			buffer = (char *) realloc(buffer, size + 1);
			if (buffer == NULL)
				return "out of memory" ; 
	        bufsize = size ; 
			
		} 
		buffer[size] = 0 ; 
		memcpy (buffer, zmq_msg_data (&reply), size);
        zmq_msg_close (&reply);
		return buffer ; 
    }

EXPORT int aclose(void * context, void * requester){ 
	zmq_close (requester);
    zmq_term (context);
    return 0;
}

EXPORT char * asendrecv(void * requester, char * message, unsigned int size){
asend(requester, message, size) ; 
return arecv(requester) ; 
}