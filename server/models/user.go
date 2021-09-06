package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	ID       primitive.ObjectID `bson:"_id,omitempty"`
	Password string             `json:"password" validate:"required,min=6"`
	Name     string             `json:"name" validate:"required,min=1"`
	Email    string             `json:"email" validate:"email,required"`
	Token    string             `json:"token"`
}
