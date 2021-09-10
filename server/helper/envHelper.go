package helper

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var envMAp map[string]string

func init() {
	byteSlite, err := os.ReadFile(".env")
	if err != nil {
		log.Fatal(err)
	}
	envMAp, err = godotenv.Unmarshal(string(byteSlite))
	if err != nil {
		log.Fatal(err)
	}
}
func GetEnv(key string) string {
	return envMAp[key]
}
