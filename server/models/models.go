package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type Note struct {
	ID   primitive.ObjectID `json:"_id,omitempty" bson:"_id,omitempty"`
	Body string             `json:"body"`
}
