package database

import (
	"context"
	"fmt"
	"log"

	"go-note/server/helper"
	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var collection *mongo.Collection
var client *mongo.Client
var envMAp map[string]string

//TODO:recode error handel
func init() {
	envMAp = helper.GetEnvMap()
	clientOptions := options.Client().ApplyURI(envMAp["CONNECTION_STRING"])
	var err error
	client, err = mongo.Connect(context.TODO(), clientOptions)
	checkErr(err)
	err = client.Ping(context.TODO(), nil)
	checkErr(err)
	collection = client.Database(envMAp["DB_NAME"]).Collection("notelist")
	fmt.Println("Connected successfully to mongoDB!")
}
func OpenCollection(collectionName string) *mongo.Collection {
	collection := client.Database(envMAp["DB_NAME"]).Collection(collectionName)
	return collection
}
func GetAllNote() (result []primitive.M) {
	cursor, err := collection.Find(context.Background(), bson.D{})
	checkErr(err)
	cursor.All(context.Background(), &result)
	return
}
func InsertOneNote(note models.Note) interface{} {
	insertResult, err := collection.InsertOne(context.Background(), note)
	checkErr(err)
	return insertResult.InsertedID
}
func DeleteNote(idHex string) string {
	id, _ := primitive.ObjectIDFromHex(idHex)
	filter := bson.M{"_id": id}
	count, err := collection.DeleteOne(context.Background(), filter)
	checkErr(err)
	if count.DeletedCount == 1 {
		return idHex
	}
	return ""
}
func DeleteAllNote() int64 {
	res, err := collection.DeleteMany(context.Background(), bson.D{})
	checkErr(err)
	return res.DeletedCount
}
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
