# ahkzmq
ahkzmq is an AutoHotkey_L wrapper for zeromq.

## zeromq
zeromq is a socket library that:

-  Carries messages across inproc, IPC, TCP, and multicast.
-  Connect N-to-N via fanout, pubsub, pipeline, request-reply.
-  supports interaction between 30+ languages including C, C++, Java, .NET, Python, and now **autohotkey!**

## Examples
1. rep/req example from the [zguide][1] 

```autohotkey
z := zstart("tcp://localhost:5555")
omsg := ["what", "else"]
zsendrcv(z, omsg)
return
#include hwjsonclient.ahk
/*
use with hwjsonserver.py
*/

```
## History
the tcp class, example from the german forum inspired
me to take another crack at zeromq in ahk. 


[1]: http://zguide.zeromq.org "zguide"