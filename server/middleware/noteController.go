package middleware

import (
	"encoding/json"
	"go-note/server/database"
	"go-note/server/models"
	"net/http"

	"github.com/gorilla/mux"
)

var GetAllNote HandlerFunctionWithUser = func(w http.ResponseWriter, r *http.Request, user models.User) {
	notes, err := database.GetAllNote(user.ID)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	json.NewEncoder(w).Encode(models.GetAllResult{Result: notes})
}

var InsertNote HandlerFunctionWithUser = func(w http.ResponseWriter, r *http.Request, user models.User) {

	var note models.Note
	err := json.NewDecoder(r.Body).Decode(&note)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}

	noteId, err := database.InsertOneNote(user.ID, note)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}

	json.NewEncoder(w).Encode(models.InsertResult{InsertedID: noteId})
}

var DeleteNote HandlerFunctionWithUser = func(w http.ResponseWriter, r *http.Request, user models.User) {

	id, err := database.DeleteNote(user.ID, mux.Vars(r)["id"])
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	json.NewEncoder(w).Encode(models.DeleteOneResult{Id: id})
}

var DeleteAllNote HandlerFunctionWithUser = func(w http.ResponseWriter, r *http.Request, user models.User) {

	count, err := database.DeleteAllNote(user.ID)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	json.NewEncoder(w).Encode(models.DeleteAllResult{DeletedCount: count})
}
