json_init(){
static wsh := ComObjCreate("MSScriptControl.ScriptControl")
wsh.language := "jscript"             
FileRead, jsonParser, % "json.js"     
wsh.Eval( jsonParser )                
json := wsh.Eval("JSON")              
if (!json){                           
    Msgbox, % "error making json parser"
}     
return json
} 
