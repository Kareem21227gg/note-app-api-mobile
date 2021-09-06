package helper

import (
	"go-note/server/models"
	"time"

	"github.com/dgrijalva/jwt-go"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func GenerateAllTokens(email string, name string, id string, oldToken string) (token string, err error) {
	return jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{"email": email, "name": name, "id": id, "created_at": time.Now()}).SignedString([]byte(GetEnvMap()["SECRET_KEY"]))
}

func ValidateToken(token string) (user models.User, errorMsg string) {
	//serach the database to find the token then return the user data from user collection
	JWTtoken, err := jwt.Parse(token, func(t *jwt.Token) (interface{}, error) { return nil, nil })
	if err != nil {
		errorMsg = "the token is invalid"
		return
	}
	dataMap := JWTtoken.Claims.(jwt.MapClaims)
	user.Email = dataMap["email"].(string)
	user.Name = dataMap["name"].(string)
	user.ID, _ = primitive.ObjectIDFromHex(dataMap["id"].(string))
	return
}
