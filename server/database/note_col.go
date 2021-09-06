package database

import (
	"context"
	"fmt"

	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func GetAllNote() (result []models.Note, err error) {
	cursor, err := noteCollection.Find(context.Background(), bson.D{})
	if err != nil {
		return nil, err
	}
	cursor.All(context.Background(), &result)
	return
}
func InsertOneNote(note models.Note) (noteId string, err error) {
	insertResult, err := noteCollection.InsertOne(context.Background(), note)
	if err != nil {
		return "", err
	}
	noteId = insertResult.InsertedID.(primitive.ObjectID).Hex()
	return
}
func DeleteNote(idHex string) (id string, err error) {
	obj, err := primitive.ObjectIDFromHex(idHex)
	if err != nil {
		return "", err
	}
	filter := bson.M{"_id": obj}
	count, err := noteCollection.DeleteOne(context.Background(), filter)
	if err != nil {
		return "", err
	}
	if count.DeletedCount != 1 {
		err = fmt.Errorf("delete failed")
		return "", err
	}
	return idHex, nil
}
func DeleteAllNote() (count int, err error) {
	res, err := noteCollection.DeleteMany(context.Background(), bson.D{})
	if err != nil {
		return 0, err
	}
	count = int(res.DeletedCount)
	return
}
