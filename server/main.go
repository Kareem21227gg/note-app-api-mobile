package main

import (
	"go-note/server/helper"
	"go-note/server/router"
	"log"
	"net/http"
)

func main() {

	r := router.Router()
	log.Fatal(http.ListenAndServe(":"+gitPort(), r))

}
func gitPort() string {

	return helper.GetEnv("PORT")

}
