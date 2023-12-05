package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/lib/pq"
)

// ensure pq driver is functional
var _ = pq.Error{}

const (
	dbName = "buildabike"
	
)