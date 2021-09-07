package database

import (
	"context"
	"fmt"

	"go-note/server/models"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

func getNoteRepo(userId primitive.ObjectID) (noteRepo models.NoteRepo, err error) {
	result := noteCollection.FindOne(context.Background(), bson.D{{"userid", userId}})
	err = result.Err()
	if err != nil {
		return
	}
	result.Decode(&noteRepo)
	return
}
func GetAllNote(userId primitive.ObjectID) (result []models.Note, err error) {
	noteRepo, err := getNoteRepo(userId)
	if err != nil {
		return nil, err
	}
	result = noteRepo.NoteList
	return
}
func InsertOneNote(userId primitive.ObjectID, note models.Note) (noteId string, err error) {
	noteRepo, err := getNoteRepo(userId)
	if err != nil {
		return
	}
	note.ID = primitive.NewObjectID()
	noteRepo.NoteList = append(noteRepo.NoteList, note)

	err = UpdateNoteRepo(noteRepo, userId)
	if err != nil {
		return
	}
	noteId = note.ID.Hex()
	return
}
func DeleteNote(userId primitive.ObjectID, idHex string) (id string, err error) {
	noteRepo, err := getNoteRepo(userId)
	if err != nil {
		return "", err
	}
	obj, err := primitive.ObjectIDFromHex(idHex)
	if err != nil {
		return "", err
	}
	for i, n := range noteRepo.NoteList {
		if n.ID == obj {
			noteRepo.NoteList = append(noteRepo.NoteList[:i], noteRepo.NoteList[i+1:]...)
			break
		}
	}
	err = UpdateNoteRepo(noteRepo, userId)
	if err != nil {
		return
	}
	return idHex, nil
}
func DeleteAllNote(userId primitive.ObjectID) (count int, err error) {
	noteRepo, err := getNoteRepo(userId)
	if err != nil {
		return 0, err
	}
	count = len(noteRepo.NoteList)
	noteRepo.NoteList = make([]models.Note, 0)
	err = UpdateNoteRepo(noteRepo, userId)
	if err != nil {
		return
	}
	return
}
func UpdateNoteRepo(noteRepo models.NoteRepo, userId primitive.ObjectID) (err error) {
	result, err := noteCollection.ReplaceOne(context.Background(), bson.M{"userid": userId}, noteRepo)
	if err != nil || result.ModifiedCount == 0 {
		err = fmt.Errorf("error will modify doc")
		return
	}
	return
}
