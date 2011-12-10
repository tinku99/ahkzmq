EnvGet, path, PATH
EnvSet, PATH, % ";" A_ScriptDir . "\Debug"
DllCall("LoadLibrary", "str", "ahk.dll")
x := dllcall("ahk\client", "Cdecl int")
msgbox % x "`n" Errorlevel  
return			    
			    
