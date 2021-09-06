package database

import (
	"context"
	"fmt"
	"go-note/server/helper"
	"log"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

var client *mongo.Client

var envMAp map[string]string
var noteCollection *mongo.Collection
var userCollection *mongo.Collection

func init() {
	envMAp = helper.GetEnvMap()
	clientOptions := options.Client().ApplyURI(envMAp["CONNECTION_STRING"])
	var err error
	client, err = mongo.Connect(context.TODO(), clientOptions)
	checkErr(err)
	err = client.Ping(context.TODO(), nil)
	checkErr(err)
	fmt.Println("Connected successfully to mongoDB!")
	userCollection = OpenCollection("user")
	noteCollection = OpenCollection("notelist")
}
func OpenCollection(collectionName string) *mongo.Collection {
	fmt.Println(envMAp["DB_NAME"], collectionName)
	return client.Database(envMAp["DB_NAME"]).Collection(collectionName)
}
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
