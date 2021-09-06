package database

import (
	"context"
	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func FindUserByEmail(email string) (exist bool, user models.User, err error) {
	result := userCollection.FindOne(context.Background(), bson.M{"email": email})
	if result.Err() != nil && result.Err() != mongo.ErrNoDocuments {
		err = result.Err()
		return
	}
	result.Decode(&user)
	if user.ID.IsZero() {
		exist = false
		return
	}
	exist = true
	return
}
func InserteUser(user models.User) (id string, err error) {
	result, err := userCollection.InsertOne(context.Background(), user)
	id = result.InsertedID.(primitive.ObjectID).Hex()
	return
}
func UpdateToken(token string, userId string) (err error) {
	obj, err := primitive.ObjectIDFromHex(userId)
	if err != nil {
		return
	}

	filter := bson.M{"_id": obj}
	result, err := userCollection.UpdateOne(
		context.Background(),
		filter,
		primitive.D{

			primitive.E{"$set", bson.E{Key: "token", Value: token}},
		},
	)
	if result.ModifiedCount == 0 {
		err = mongo.ErrNoDocuments
	}
	return
}
func DeleteAllUsers() (deletedCount int, err error) {

	result, err := userCollection.DeleteMany(context.Background(), bson.D{})
	deletedCount = int(result.DeletedCount)
	return
}

//func UpdateUser() {}
