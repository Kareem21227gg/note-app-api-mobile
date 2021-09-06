package database

import (
	"context"

	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func GetAllNote() (result []models.Note) {
	cursor, err := noteCollection.Find(context.Background(), bson.D{})
	checkErr(err)
	cursor.All(context.Background(), &result)
	return
}
func InsertOneNote(note models.Note) string {
	insertResult, err := noteCollection.InsertOne(context.Background(), note)
	checkErr(err)
	return insertResult.InsertedID.(string)
}
func DeleteNote(idHex string) string {
	id, _ := primitive.ObjectIDFromHex(idHex)
	filter := bson.M{"_id": id}
	count, err := noteCollection.DeleteOne(context.Background(), filter)
	checkErr(err)
	if count.DeletedCount == 1 {
		return idHex
	}
	return ""
}
func DeleteAllNote() int64 {
	res, err := noteCollection.DeleteMany(context.Background(), bson.D{})
	checkErr(err)
	return res.DeletedCount
}
