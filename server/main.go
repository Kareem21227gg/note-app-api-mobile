package main

import (
	"fmt"
	"go-note/server/helper"
	"go-note/server/router"
	"log"
	"net/http"
)

func main() {
	envMAp := helper.GetEnvMap()
	r := router.Router()
	fmt.Println("Starting server on the port ", envMAp["PORT"], "...")
	log.Fatal(http.ListenAndServe(":"+envMAp["PORT"], r))

}
