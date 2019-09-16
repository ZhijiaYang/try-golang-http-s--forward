package main

import (
	"net/http"
	"net/http/httputil"
	"time"
)

const(
	crt = "./pki/server.crt"
	key = "./pki/server.key"
)

func ForwardRequest(w http.ResponseWriter, req *http.Request) {
	host := req.Header.Get("BACKEND")

	director := func(req *http.Request) {
		req.URL.Scheme = "http"
		req.URL.Host = host
		req.Host = host
	}
	proxy := &httputil.ReverseProxy{Director: director}
	proxy.ServeHTTP(w, req)
}

func main(){
	http.HandleFunc("/hello", ForwardRequest)
	go http.ListenAndServe(":80", nil)
	go http.ListenAndServeTLS(":443", crt, key, nil)
	time.Sleep(10*time.Second)
}