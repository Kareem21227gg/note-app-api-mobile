package database

import (
	"context"
	"fmt"
	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func FindUserByToken(token string) (exist bool, user models.User, err error) {
	result := userCollection.FindOne(context.Background(), bson.M{"token": token})
	exist = false
	if result.Err() != nil {
		if result.Err() == mongo.ErrNoDocuments {
			fmt.Printf("user: %v\n", user)
			return
		}
		err = result.Err()
		return
	}
	err = result.Decode(&user)

	if err != nil {
		return
	}
	exist = true
	return
}

func FindUserByEmail(email string) (exist bool, user models.User, err error) {

	exist = false
	result := userCollection.FindOne(context.Background(), bson.M{"email": email})

	if result.Err() != nil {
		if result.Err() == mongo.ErrNoDocuments {
			return
		}
		err = result.Err()
		return
	}
	err = result.Decode(&user)

	if err != nil {
		return
	}
	exist = true
	return
}
func InserteUser(user models.User) (id string, err error) {

	result, err := userCollection.InsertOne(context.Background(), user)
	if err != nil {
		return
	}
	id = result.InsertedID.(primitive.ObjectID).Hex()
	noteRepo := models.NoteRepo{UserId: result.InsertedID.(primitive.ObjectID), NoteList: make([]models.Note, 0)}
	_, err = noteCollection.InsertOne(context.Background(), noteRepo)
	if err != nil {
		return
	}
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

		bson.D{{"$set", bson.D{bson.E{"token", token}}}},
	)
	if err != nil {
		return
	}
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

func ValidateToken(token string) (user models.User, err error) {
	exist, user, err := FindUserByToken(token)
	if !exist || err != nil {
		err = fmt.Errorf("invalid token")
	}
	return
}
