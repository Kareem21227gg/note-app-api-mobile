package helper

import (
	"github.com/dgrijalva/jwt-go"
)

func GenerateAllTokens(email string, name string, id string, oldToken string) (token string, err error) {
	return jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{"id": id}).SignedString([]byte(GetEnvMap()["SECRET_KEY"]))
}
