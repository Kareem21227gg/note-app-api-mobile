package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Note struct {
	ID   primitive.ObjectID `bson:"_id,omitempty"`
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
type ErrorResult struct {
	Message string `json:"error_msg"`
}
type SingUpResult struct {
	Id interface{} `json:"user_id"`
}
type SingInResult struct {
	User User `json:"user_data"`
}
