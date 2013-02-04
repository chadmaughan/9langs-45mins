// Download the pgsql library from github
//	 go help get
//	 go get github.com/lxn/go-pgsql
package main

import (
	"database/sql"
	"fmt"
	"log"
)

import (
	_ "github.com/lxn/go-pgsql"
)

type Temp struct {
	id          int
	location    string
	temperature float32
}

func main() {

	// connect to database
	//	expects a postgres instance running on the default port (5432) with a database 'temperature'
	//
	// $ pg_dump -h localhost -t temperature -s -x
	//	CREATE TABLE temperature (
	//    id integer NOT NULL,
	//    location character varying(20),
	//    time_stamp timestamp without time zone DEFAULT now(),
	//    temperature real
	//	);
	db, err := sql.Open("postgres", "user=chad password= host=localhost port=5432 dbname=temperature sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}

	defer db.Close()

	stmt, err := db.Prepare("SELECT id, location, temperature FROM temperature")
	rows, err := stmt.Query()
	if err != nil {
		log.Fatal(err)
	}

	// similar to a C (or Java) while
	for rows.Next() {

		var temp Temp

		err = rows.Scan(&temp.id, &temp.location, &temp.temperature)
		if err != nil {
			fmt.Printf("Error while getting row data: %s\n", err)
			log.Fatal(err)
		}

		fmt.Printf("id => %d\n", temp.id)
		fmt.Printf("location => %s\n", temp.location)
		fmt.Printf("temperature => %f\n", temp.temperature)
	}
}
