package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	ID       primitive.ObjectID `bson:"_id,omitempty"`
	Password string             `json:"password" validate:"required,min=6"`
	Name     string             `json:"name" validate:"required,min=1"`
	Email    string             `json:"email" validate:"email,required"`
	Token    string             `json:"token"`
}

type Note struct {
	ID   primitive.ObjectID `bson:"_id,omitempty"`
	Body string             `json:"body"`
}

type InsertResult struct {
	InsertedID string `json:"inserted_id"`
}

type DeleteAllResult struct {
	DeletedCount int64 `json:"delete_counter"`
}

type DeleteOneResult struct {
	Id string `json:"id"`
}
type GetAllResult struct {
	Result []Note `json:"result"`
}
type ErrorResult struct {
	Message string `json:"error_msg"`
}
type SingUpResult struct {
	Id string `json:"user_id"`
}
type SingInResult struct {
	User User `json:"user_data"`
}
