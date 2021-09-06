package middleware

import (
	"encoding/json"
	"net/http"

	"go-note/server/database"
	"go-note/server/models"

	"github.com/gorilla/mux"
)

func GetAllNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	json.NewEncoder(w).Encode(models.GetAllResult{Result: database.GetAllNote()})
}

func InsertNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	var note models.Note
	err := json.NewDecoder(r.Body).Decode(&note)
	if err != nil {
		json.NewEncoder(w).Encode(models.ErrorResult{Message: err.Error()})
		return
	}
	var res models.InsertResult
	res.InsertedID = database.InsertOneNote(note)
	json.NewEncoder(w).Encode(res)
}

func DeleteNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	//Could i be more complicated???
	json.NewEncoder(w).Encode(models.DeleteOneResult{Id: database.DeleteNote(mux.Vars(r)["id"])})
}

func DeleteAllNote(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	count := database.DeleteAllNote()
	inter := models.DeleteAllResult{DeletedCount: count}
	json.NewEncoder(w).Encode(inter)
}
