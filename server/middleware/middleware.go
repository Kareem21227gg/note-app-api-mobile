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
	//what haben to the data when change the namer of db
	collection = client.Database(dbName).Collection(collName)
	fmt.Printf("\"Collection instance created!\": %v\n", "Collection instance created!")
}

func GetAllNote(w http.ResponseWriter, r *http.Request) {
	//what is the fuck all this header for
	w.Header().Set("Context-Type", "applictaon/x-www-from-urlencoded")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Content-Type", "json")
	payload := getAllNote()
	json.NewEncoder(w).Encode(payload)
}
func getAllNote() (results []primitive.M) {
	cursor, err := collection.Find(context.Background(), bson.D{})
	if err != nil {
		log.Fatal(err)
	}
	//should be try next !!!!!!!!!!!!!
	for cursor.Next(context.Background()) {
		var result bson.M
		err := cursor.Decode(&result)
		if err != nil {
			log.Fatal(err)
		}
		results = append(results, result)
	}
	cursor.Close(context.Background())
	return
}

func CreateNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Context-Type", "application/x-www-form-urlencoded")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	var note models.Note
	err := json.NewDecoder(r.Body).Decode(&note)
	if err != nil {
		fmt.Printf("r.Body: %v\n", r.Body)
		json.NewEncoder(w).Encode(err)
		return
	}
	fmt.Println(note, r.Body)
	insertOneNote(note)
	json.NewEncoder(w).Encode(note)
}

func insertOneNote(note models.Note) {
	insertResult, err := collection.InsertOne(context.Background(), note)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Inserted a Single Record ", insertResult.InsertedID)
}

func DeleteNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Context-Type", "application/x-www-form-urlencoded")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "DELETE")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")
	params := mux.Vars(r)
	deleteNote(params["id"])
	json.NewEncoder(w).Encode(params["id"])
}
func deleteNote(idHex string) {
	id, _ := primitive.ObjectIDFromHex(idHex)
	fmt.Printf("id: %v\n", id)
	filter := bson.M{"_id": id}
	d, err := collection.DeleteOne(context.Background(), filter)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Deleted Document", d.DeletedCount)
}

func DeleteAllNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")

	count := deleteAllNote()
	inter := struct {
		DeletedCount int64 `json:"delete_counter"`
	}{}
	inter.DeletedCount = count
	json.NewEncoder(w).Encode(inter)
}
func deleteAllNote() int64 {
	res, err := collection.DeleteMany(context.Background(), bson.D{})
	if err != nil {
		log.Fatal(err)
	}
	return res.DeletedCount
}
