package middleware

import (
	"encoding/json"
	"go-note/server/database"
	"go-note/server/helper"
	"go-note/server/models"
	"net/http"

	"github.com/go-playground/validator"
)

var validate = validator.New()

var SignUp HandlerFunction = func(w http.ResponseWriter, r *http.Request) {
	var user models.User
	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}

	validationErr := validate.Struct(user)
	if validationErr != nil {
		writeErrorMes(w, validationErr.Error())
		return
	}

	exist, _, err := database.FindUserByEmail(user.Email)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	if exist {
		writeErrorMes(w, "this email or phone number already exists")
		return
	}
	password, err := helper.Hashpassword(user.Password)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	user.Password = password

	token, err := helper.GenerateAllTokens(user.Email)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	user.Token = token
	_, err = database.InserteUser(user)
	if err != nil {
		writeErrorMes(w, "User item was not created")
		return
	}
	json.NewEncoder(w).Encode(models.SingUpResult{Name: user.Name, Email: user.Email, Token: user.Token})
}

var Login HandlerFunction = func(w http.ResponseWriter, r *http.Request) {
	var user models.User
	var foundUser models.User

	err := json.NewDecoder(r.Body).Decode(&user)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}

	exist, foundUser, _ := database.FindUserByEmail(user.Email)

	if !exist {
		writeErrorMes(w, "email or passowrd is incorrect")
		return
	}
	passwordIsValid, err := helper.VerifyPassword(user.Password, foundUser.Password)
	if !passwordIsValid || err != nil {
		writeErrorMes(w, "email or password incorrect")
		return
	}

	token, err := helper.GenerateAllTokens(foundUser.Email)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	err = database.UpdateToken(token, foundUser.ID.Hex())
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	foundUser.Token = token
	json.NewEncoder(w).Encode(models.SingInResult{Name: foundUser.Name, Email: foundUser.Email, Token: foundUser.Token})
}
