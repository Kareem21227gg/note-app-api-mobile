package router

import (
	"go-note/server/middleware"
	"net/http"

	"github.com/gorilla/mux"
)

func Router() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/", func(rw http.ResponseWriter, r *http.Request) { rw.Write([]byte("<h1>kareem mather fucker<h1/>")) })
	router.HandleFunc("/api/note", middleware.GetAllNote).Methods("GET", "OPTIONS")
	router.HandleFunc("/api/note", middleware.CreateNote).Methods("POST", "OPTIONS")
	router.HandleFunc("/api/deleteNote/{id}", middleware.DeleteNote).Methods("DELETE", "OPTIONS")

	return router
}
