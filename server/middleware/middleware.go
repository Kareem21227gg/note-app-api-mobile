package middleware

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"go-note/server/models"

	"github.com/gorilla/mux"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

const connectionString = "mongodb://127.0.0.1:27017" //27017
const dbName = "test"
const collName = "notelist"

var collection *mongo.Collection

func init() {
	clientOptions := options.Client().ApplyURI(connectionString)
	client, err := mongo.Connect(context.TODO(), clientOptions)
	if err != nil {
		log.Fatal(err)
	}
	err = client.Ping(context.TODO(), nil)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("\"Connected successfully to mongoDB!\": %v\n", "Connected successfully to mongoDB!")
	collection = client.Database(dbName).Collection(collName)
	fmt.Printf("\"Collection instance created!\": %v\n", "Collection instance created!")
}

func GetAllNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	json.NewEncoder(w).Encode(models.GetAllResult{Result: getAllNote()})
}
func getAllNote() (result []primitive.M) {
	cursor, err := collection.Find(context.Background(), bson.D{})
	if err != nil {
		log.Fatal(err)
	}
	cursor.All(context.Background(), &result)
	return
}

func CreateNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	var note models.Note
	err := json.NewDecoder(r.Body).Decode(&note)
	if err != nil {
		json.NewEncoder(w).Encode(err)
		return
	}
	var res models.InsertResult
	res.InsertedID = insertOneNote(note)
	json.NewEncoder(w).Encode(res)
}

func insertOneNote(note models.Note) interface{} {
	insertResult, err := collection.InsertOne(context.Background(), note)
	if err != nil {
		log.Fatal(err)
	}
	return insertResult.InsertedID
}

func DeleteNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	//Could i be more complicated???
	json.NewEncoder(w).Encode(models.DeleteOneResult{Id: deleteNote(mux.Vars(r)["id"])})
}
func deleteNote(idHex string) string {
	id, _ := primitive.ObjectIDFromHex(idHex)
	filter := bson.M{"_id": id}
	count, err := collection.DeleteOne(context.Background(), filter)
	if err != nil {
		log.Fatal(err)
	}
	if count.DeletedCount == 1 {
		return idHex
	}
	return ""
}

func DeleteAllNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")

	count := deleteAllNote()
	inter := models.DeleteAllResult{DeletedCount: count}
	json.NewEncoder(w).Encode(inter)
}
func deleteAllNote() int64 {
	res, err := collection.DeleteMany(context.Background(), bson.D{})
	if err != nil {
		log.Fatal(err)
	}
	return res.DeletedCount
}
