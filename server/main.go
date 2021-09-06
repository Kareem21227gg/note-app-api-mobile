package main

import (
	"fmt"
	"go-note/server/helper"

	"github.com/dgrijalva/jwt-go"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func main() {
	envMAp := helper.GetEnvMap()
	// r := router.Router()
	// fmt.Println("Starting server on the port ", envMAp["PORT"], "...")
	// log.Fatal(http.ListenAndServe(":"+envMAp["PORT"], r))
	is := primitive.NewObjectID()
	fmt.Printf("is: %v\n", is)
	token, _ := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{"email": "kareem20001227@gmail.com", "name": "kareem21227", "id": is.Hex()}).SignedString([]byte(envMAp["SECRET_KEY"]))
	va, err := jwt.Parse(token, func(t *jwt.Token) (interface{}, error) { return nil, nil })
	if err != nil {
		fmt.Printf("err: %v\n", err)
	}
	is, _ = primitive.ObjectIDFromHex(va.Claims.(jwt.MapClaims)["id"].(string))
	fmt.Printf("va: %v\n", is)
}
