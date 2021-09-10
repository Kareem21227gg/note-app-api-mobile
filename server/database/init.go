package database

import (
	"context"
	"fmt"
	"go-note/server/helper"
	"log"
	"time"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var client *mongo.Client

var noteCollection *mongo.Collection
var userCollection *mongo.Collection

func init() {

	clientOptions := options.Client().ApplyURI(helper.GetEnv("CONNECTION_STRING"))
	var err error
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	client, err = mongo.Connect(ctx, clientOptions)
	checkErr(err)
	err = client.Ping(context.TODO(), nil)
	checkErr(err)
	fmt.Println("Connected successfully to mongoDB!")
	userCollection = OpenCollection("user")
	noteCollection = OpenCollection("notelist")
}
func OpenCollection(collectionName string) *mongo.Collection {
	fmt.Println(helper.GetEnv("DB_NAME"), collectionName)
	return client.Database(helper.GetEnv("DB_NAME")).Collection(collectionName)
}
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
