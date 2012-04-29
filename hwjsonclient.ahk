#singleinstance off	
z := zstart("tcp://localhost:5555")
omsg := ["hello", "from", "autohotkey"]
msg := zsendrcv(z, omsg)
loop % msg.count{
msgbox % msg[A_Index]
}

return

f2::
zsendrcv(z, omsg)
return
;; hotkeys                                  
!r::reload

!q::exitapp
  
;; includes
#include lib\zmq.ahk
#include lib\json.ahk
