package middleware

import (
	"encoding/json"
	"fmt"
	"go-note/server/database"
	"go-note/server/helper"
	"go-note/server/models"
	"log"
	"net/http"

	"github.com/go-playground/validator"
)

var validate = validator.New()

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

	exist, _, err := database.FindUserByEmail(user.Email)
	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: err.Error()})
		return
	}
	if exist {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "this email or phone number already exists"})
		return
	}
	password, _ := helper.Hashpassword(user.Password)
	user.Password = password

	token, _ := helper.GenerateAllTokens(user.Email, user.Name, user.ID.Hex(), user.Token)
	user.Token = token
	userId, err := database.InserteUser(user)
	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "User item was not created"})
		return
	}
	json.NewEncoder(w).Encode(models.SingUpResult{Id: userId})
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

	exist, foundUser, _ := database.FindUserByEmail(user.Email)

	if !exist {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: "email or passowrd is incorrect"})
		return
	}
	passwordIsValid, msg := helper.VerifyPassword(user.Password, foundUser.Password)
	if !passwordIsValid {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: msg})
		return
	}

	token, err := helper.GenerateAllTokens(foundUser.Email, foundUser.Name, foundUser.ID.Hex(), foundUser.Token)
	if err != nil {
		log.Fatal(err)
	}
	err = database.UpdateToken(token, foundUser.ID.Hex())
	if err != nil {
		log.Fatal(err)
	}
	json.NewEncoder(w).Encode(models.SingInResult{User: foundUser})
}
