package router

import (
	"go-note/server/middleware"
	"net/http"

	"github.com/gorilla/mux"
)

func Router() *mux.Router {
	router := mux.NewRouter()
	router.NotFoundHandler = http.NotFoundHandler()
	router.HandleFunc("/api/note", middleware.GetAllNote.TokenRequired).Methods("GET", "OPTIONS")
	router.HandleFunc("/api/note", middleware.InsertNote.TokenRequired).Methods("POST", "OPTIONS")
	router.HandleFunc("/api/deleteNote/{id}", middleware.DeleteNote.TokenRequired).Methods("DELETE", "OPTIONS")
	router.HandleFunc("/api/deleteNote", middleware.DeleteAllNote.TokenRequired).Methods("DELETE", "OPTIONS")
	router.HandleFunc("/api/singup", middleware.SignUp.EmptyMiddleware).Methods("POST", "OPTIONS")
	router.HandleFunc("/api/login", middleware.Login.EmptyMiddleware).Methods("POST", "OPTIONS")
	return router
}
