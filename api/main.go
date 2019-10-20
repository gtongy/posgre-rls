package main

import (
	"context"
	"log"

	dbr "github.com/gocraft/dbr/v2"
	_ "github.com/lib/pq"
)

var (
	dbName = "rls"
	host   = "postgres"
	port   = "5432"
)

type User struct {
	ID       int
	TenantID int
	Name     string
}

func main() {
	// 各ユーザー毎に別のコネクションを貼る
	rootDB, err := rootDB()
	defer rootDB.Close()
	if err != nil {
		log.Fatal("rootDB db connect failed!")
	}
	tenant1DB, err := tenant1DB()
	defer tenant1DB.Close()
	if err != nil {
		log.Fatal("tenant1 db connect failed!")
	}
	tenant2DB, err := tenant2DB()
	defer tenant2DB.Close()
	if err != nil {
		log.Fatal("tenant2 db connect failed!")
	}
	tenant3DB, err := tenant3DB()
	defer tenant3DB.Close()
	if err != nil {
		log.Fatal("tenant3 db connect failed!")
	}
	ctx := context.Background()
	var rootUsers, tenant1Users, tenant2Users, tenant3Users []User
	// 各ユーザーごとにusersを検索
	rootDB.NewSession(nil).Select("*").From("users").LoadContext(ctx, &rootUsers)
	tenant1DB.NewSession(nil).Select("*").From("users").LoadContext(ctx, &tenant1Users)
	tenant2DB.NewSession(nil).Select("*").From("users").LoadContext(ctx, &tenant2Users)
	tenant3DB.NewSession(nil).Select("*").From("users").LoadContext(ctx, &tenant3Users)

	// 結果は以下のようになる。
	// [{1 1 tenant1-user1} {2 1 tenant1-user2} {3 1 tenant1-user3} {4 2 tenant2-user1} {5 2 tenant2-user2} {6 2 tenant2-user3}]
	log.Println(rootUsers)
	// [{1 1 tenant1-user1} {2 1 tenant1-user2} {3 1 tenant1-user3}]
	log.Println(tenant1Users)
	// [{4 2 tenant2-user1} {5 2 tenant2-user2} {6 2 tenant2-user3}]
	log.Println(tenant2Users)
	// []
	log.Println(tenant3Users)
}

func rootDB() (*dbr.Connection, error) {
	return dbr.Open("postgres", "host="+host+" port="+port+" user=dev password=dev dbname="+dbName+" sslmode=disable", nil)
}

func tenant1DB() (*dbr.Connection, error) {
	return dbr.Open("postgres", "host="+host+" port="+port+" user=tenant$1 password=tenant$1 dbname="+dbName+" sslmode=disable", nil)
}

func tenant2DB() (*dbr.Connection, error) {
	return dbr.Open("postgres", "host="+host+" port="+port+" user=tenant$2 password=tenant$2 dbname="+dbName+" sslmode=disable", nil)
}

func tenant3DB() (*dbr.Connection, error) {
	return dbr.Open("postgres", "host="+host+" port="+port+" user=tenant$3 password=tenant$3 dbname="+dbName+" sslmode=disable", nil)
}
