(defun server ()
  "Bind to socket and wait to receive a message.  After receipt,
  return the message \"OK\"."
  (zmq:with-context (ctx 1)
    (zmq:with-socket (socket ctx zmq:rep)
      (zmq:bind socket "tcp://*:5555")
      (loop
       (let ((query (make-instance 'zmq:msg)))
         (zmq:recv socket query)
         (format t "Recieved query: '~A'~%"
                 (zmq:msg-data-as-string query) ))
       (zmq:send socket (make-instance 'zmq:msg :data "OK")) ))))
 
 
