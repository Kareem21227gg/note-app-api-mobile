package main

import (
	"fmt"
	"go-note/server/helper"
	"go-note/server/router"
	"log"
	"net/http"
	"os"
)

func main() {
	fmt.Println("CONNECTION_STRING: ", helper.GetEnv("CONNECTION_STRING"))
	r := router.Router()
	log.Fatal(http.ListenAndServe(":"+gitPort(), r))

}
func gitPort() string {
	port := os.Getenv("PORT")
	if port == "" {
		return helper.GetEnv("PORT")
	}
	return port
}
