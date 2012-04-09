EnvGet, path, PATH  			       			   
EnvSet, PATH, % ";" A_ScriptDir . "\Debug"     			   
DllCall("LoadLibrary", "str", "ahk.dll")       			   	   
context := dllcall("ahk\acontext", "cdecl ptr")			   	   
socket := dllcall("ahk\areqsocket", "ptr", context			   
, "astr", "tcp://localhost:5555"	       				   
, "cdecl ptr")      			       				   
loop, 5{       	    			       				   
msg := ["hello",  A_Index]		       				   
jmsg := json_to(msg) 			       				   
hr := dllcall("ahk\asendrecv", "ptr", socket, "astr", jmsg, "uint", strlen(jmsg)
, "cdecl astr")	      
sleep, 500  	  
tooltip % hr
}
return			    
			    
!r::reload
!q::exitapp
