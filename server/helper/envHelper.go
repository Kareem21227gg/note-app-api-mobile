package helper

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var envMAp map[string]string

func GetEnvMap() map[string]string {
	byteSlite, err := os.ReadFile(".env")
	if err != nil {
		log.Fatal(err)
	}
	envMAp, err = godotenv.Unmarshal(string(byteSlite))
	if err != nil {
		log.Fatal(err)
	}
	return envMAp
}
