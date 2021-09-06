package helper

import (
	"golang.org/x/crypto/bcrypt"
)

func Hashpassword(passworsd string) (hash string, errorMsg string) {
	bytehash, err := bcrypt.GenerateFromPassword([]byte(passworsd), 16)
	if err != nil {
		errorMsg = err.Error()
	}
	hash = string(bytehash)
	return
}

func VerifyPassword(userPassword string, providedPassword string) (valid bool, errorMsg string) {
	err := bcrypt.CompareHashAndPassword([]byte(providedPassword), []byte(userPassword))
	valid = true
	errorMsg = ""

	if err != nil {
		errorMsg = "passowrd is incorrect"
		valid = false
	}
	return
}
