package helper

import (
	"context"
	"go-note/server/models"

	"log"

	"github.com/dgrijalva/jwt-go"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

var SECRET_KEY string

func init() {
	SECRET_KEY = GetEnvMap()["SECRET_KEY"]
}
func GenerateAllTokens(email string, name string, id string) (token string, err error) {
	return jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{"email": email, "name": name, "id": id}).SignedString([]byte(SECRET_KEY))
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

func UpdateAllTokens(token string, userId string, userCollection *mongo.Collection) {
	filter := bson.M{"_id": userId}
	_, err := userCollection.UpdateOne(
		context.Background(),
		filter,
		primitive.D{
			primitive.E{"$set", bson.E{Key: "token", Value: token}},
		},
	)
	if err != nil {
		log.Panic(err)
	}

}
