package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	port := "3002"
	if fromEnv := os.Getenv("PORT"); fromEnv != "" {
		port = fromEnv
	}
	http.HandleFunc("/", foo)
	log.Printf("Server listening on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func foo(w http.ResponseWriter, r *http.Request) {
	// This request should not throw an error becasue we have added root ca to the certificate chain.
	resp, err := http.Get("https://monument-software.ch/")
	if err != nil {
		fmt.Fprintf(w, "Error: %s", err)
		return
	}
	defer resp.Body.Close()
	fmt.Fprintf(w, "Success!")
}
