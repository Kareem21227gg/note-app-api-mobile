package helper

import (
	"time"

	"github.com/dgrijalva/jwt-go"
)

type SignedDetails struct {
	Email string
	jwt.StandardClaims
}

//
func GenerateAllTokens(email string) (token string, err error) {
	claims := &SignedDetails{
		Email: email,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Local().Add(time.Hour * time.Duration(24)).Unix(),
		},
	}
	return jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString([]byte(GetEnv("SECRET_KEY")))

}
