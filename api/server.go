package api

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Service struct {
	ds     DataSource
	router *gin.Engine
}

func NewService() Service {
	ds, err := NewDataSource()
	if err != nil {
		fmt.Print(err)
	}
	s := Service{
		ds: ds,
	}

	router := gin.Default()
	api := router.Group("/api")
	api.GET("/healthz", s.getHealth)

	v1 := api.Group("/v1")

	// /api/v1/part/<id>
	v1.GET("/part/:id", s.getParts)
	// /api/v1/parts/
	v1.GET("/part/:category", s.getParts)

	s.router = router
	return s
}

func (s Service) Run() error {
	return s.router.Run(":8080")
}

// getHealth responds with a basic health check.
func (s Service) getHealth(c *gin.Context) {
	c.Status(http.StatusOK)
}

// postDB creates the db in postgress.
func (s Service) postDB(c *gin.Context) {
	err := s.ds.CreateDB()
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
	}
}

// deleteDB deletes the existing db in postgress.
func (s Service) deleteDB(c *gin.Context) {
	err := s.ds.DeleteDB()
	if err != nil {
		c.AbortWithError(http.StatusInternalServerError, err)
	}
}

// getParts responds with information about all parts in DB
func (s Service) getParts(c *gin.Context) {
	// TODO
}
