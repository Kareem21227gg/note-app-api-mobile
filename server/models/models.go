package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Note struct {
	ID   primitive.ObjectID `json:"_id,omitempty" bson:"_id,omitempty"`
	Body string             `json:"body"`
}

type InsertResult struct {
	InsertedID interface{} `json:"inserted_id"`
}

type DeleteAllResult struct {
	DeletedCount int64 `json:"delete_counter"`
}

type DeleteOneResult struct {
	Id string `json:"id"`
}
type GetAllResult struct {
	Result []primitive.M `json:"result"`
}
