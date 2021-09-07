package middleware

import (
	"encoding/json"
	"net/http"

	"go-note/server/database"
	"go-note/server/models"
)

type HandlerFunctionWithUser func(http.ResponseWriter, *http.Request, models.User)
type HandlerFunction func(http.ResponseWriter, *http.Request)

func (f HandlerFunctionWithUser) TokenRequired(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	token := r.Header.Get("token")
	if token == "" {
		writeErrorMes(w, "token required")
		return
	}
	user, err := database.ValidateToken(token)
	if err != nil {
		writeErrorMes(w, err.Error())
		return
	}
	f(w, r, user)
}

func (f HandlerFunction) EmptyMiddleware(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "json")
	f(w, r)
}
func writeErrorMes(w http.ResponseWriter, msg string) {
	json.NewEncoder(w).Encode(models.ErrorResult{Message: msg})
}
