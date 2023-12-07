package api

import (
	"github.com/lib/pq"
)

// ensure pq driver is functional
var _ = pq.Error{}

const (
	dbName = "buildabike"
)
