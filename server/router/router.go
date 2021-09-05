package router

import (
	"go-note/server/middleware"

	"github.com/gorilla/mux"
)

func Router() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/api/note", middleware.GetAllNote).Methods("GET", "OPTIONS")
	router.HandleFunc("/api/note", middleware.InsertNote).Methods("POST", "OPTIONS")
	router.HandleFunc("/api/deleteNote/{id}", middleware.DeleteNote).Methods("DELETE", "OPTIONS")
	router.HandleFunc("/api/deleteNote", middleware.DeleteAllNote).Methods("DELETE", "OPTIONS")

	return router
}
