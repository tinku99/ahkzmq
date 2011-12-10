EnvGet, path, PATH						   
EnvSet, PATH, % ";" A_ScriptDir . "\Debug"			   
DllCall("LoadLibrary", "str", "ahk.dll")			   
context := dllcall("ahk\acontext", "cdecl ptr")			   
socket := dllcall("ahk\areqsocket", "ptr", context
, "astr", "tcp://localhost:5555"
, "cdecl ptr")   
loop, 5{       
msg := "hello " A_Index
/*
hr := dllcall("ahk\asend", "ptr", socket, "astr", msg, "uint", strlen(msg)
, "cdecl int") 							  
msg := dllcall("ahk\arecv", "ptr", socket, "cdecl astr")       	  
*/
hr := dllcall("ahk\asendrecv", "ptr", socket, "astr", msg, "uint", strlen(msg)
, "cdecl int")
sleep, 500
tooltip % msg "`n" Errorlevel  			      
}
return			    
			    
!r::reload
!q::exitapp
