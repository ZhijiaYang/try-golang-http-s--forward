package main

import (
	"fmt"
	"net/http"
	"time"
)

func main(){
	go simpleServer(8080).ListenAndServe()
	go simpleServer(8081).ListenAndServe()
	time.Sleep(10*time.Second) // exit after some time
}

func simpleServer(port int)*http.Server{
	addr := fmt.Sprintf(":%d", port)
	msg := fmt.Sprintf("hello, i am %d.\n", port)

	httpMux := http.NewServeMux()
	httpMux.HandleFunc("/hello",
		func (w http.ResponseWriter, req *http.Request){
			w.Write([]byte(msg))
	})

	return &http.Server{Addr: addr, Handler: httpMux}
}