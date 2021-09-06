package controllers

import (
	"context"
	"encoding/json"
	"fmt"
	"go-note/server/database"
	"go-note/server/helper"
	"go-note/server/models"
	"log"
	"net/http"

	"github.com/go-playground/validator"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"golang.org/x/crypto/bcrypt"
)

var userCollection *mongo.Collection = database.OpenCollection("user")
var validate = validator.New()

func Hashpassword(passworsd string) string {
	hash, err := bcrypt.GenerateFromPassword([]byte(passworsd), 16)
	if err != nil {
		log.Fatal(err)
	}
	return string(hash)
}

func VerifyPassword(userPassword string, providedPassword string) (bool, string) {
	err := bcrypt.CompareHashAndPassword([]byte(providedPassword), []byte(userPassword))
	check := true
	msg := ""

	if err != nil {
		msg = "login or passowrd is incorrect"
		check = false
	}

	return check, msg
}
func SignUp(w http.ResponseWriter, r *http.Request) {
	var user models.User
	err := json.NewDecoder(r.Body).Decode(&user)
	fmt.Printf("user,p,e,n: %v\n", user)
	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: err.Error()})
		return
	}

	validationErr := validate.Struct(user)
	if validationErr != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: validationErr.Error()})
		return
	}

	count, err := userCollection.CountDocuments(context.Background(), bson.M{"email": user.Email})
	if err != nil {
		log.Panic(err)
		json.NewEncoder(w).Encode(models.ErrorResult{Message: err.Error()})
		return
	}

	password := Hashpassword(user.Password)
	user.Password = password

	if count > 0 {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "this email or phone number already exists"})
		return
	}

	token, _ := helper.GenerateAllTokens(user.Email, user.Name, user.ID.Hex())
	user.Token = token

	resultInsertionNumber, insertErr := userCollection.InsertOne(context.Background(), user)
	if insertErr != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "User item was not created"})
		return
	}

	json.NewEncoder(w).Encode(models.SingUpResult{Id: resultInsertionNumber.InsertedID})
}

func Login(w http.ResponseWriter, r *http.Request) {
	var user models.User
	var foundUser models.User

	err := json.NewDecoder(r.Body).Decode(&user)
	fmt.Printf("user,p,e,n: %v\n", user)
	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: err.Error()})
		return
	}

	err = userCollection.FindOne(context.Background(), bson.M{"email": user.Email}).Decode(&foundUser)

	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "login or passowrd is incorrect"})
		return
	}
	passwordIsValid, msg := VerifyPassword(user.Password, foundUser.Password)
	if passwordIsValid {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: msg})
		return
	}

	token, err := helper.GenerateAllTokens(foundUser.Email, foundUser.Name, foundUser.ID.Hex())

	helper.UpdateAllTokens(token, foundUser.ID.Hex(), userCollection)

	json.NewEncoder(w).Encode(models.SingInResult{User: foundUser})
}
