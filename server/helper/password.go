package helper

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func Hashpassword(passworsd string) (hash string, err error) {
	bytehash, err := bcrypt.GenerateFromPassword([]byte(passworsd), 16)
	if err != nil {
		return
	}
	hash = string(bytehash)
	return
}

func VerifyPassword(userPassword string, providedPassword string) (valid bool, err error) {
	err = bcrypt.CompareHashAndPassword([]byte(providedPassword), []byte(userPassword))
	valid = true
	if err != nil {
		err = fmt.Errorf("passowrd is invalid")
		valid = false
	}
	return
}
