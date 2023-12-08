package api

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type DataSource interface {
	GetBike(uuid.UUID) (*Bike, error)
	SetBike(uuid.UUID, *Bike) error
	GetParts(string) (*Catalog, error)
}

type Service struct {
	ds     DataSource
	router *gin.Engine
}

func NewService() Service {
	ds, err := NewLocalDataSource()
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

	// /api/v1/bike/<id>
	v1.GET("/bike/:id", s.getBike)
	// /api/v1/bike/<id>
	v1.POST("/bike/:id", s.getBike)

	// /api/v1/parts
	v1.GET("/parts", s.getParts)
	// /api/v1/parts/<category>
	v1.GET("/parts/:category", s.getParts)

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

// getBike responds with information about a single bike
func (s Service) getBike(c *gin.Context) {
	// we declare err here and then defer its handling
	// so that err can be set anywhere and then will be handled when we return
	var err error
	defer func() { handleError(c, err) }()

	paramBikeID := c.Params.ByName("id")
	bikeID := uuid.MustParse(paramBikeID)
	bike, err := s.ds.GetBike(bikeID)
	if err != nil {
		return
	}

	bikeJSON, err := json.Marshal(bike)
	if err != nil {
		return
	}

	if _, err = c.Writer.Write(bikeJSON); err != nil {
		return
	}
}

// postBike saves a bike
func (s Service) postBike(c *gin.Context) {
	// we declare err here and then defer its handling
	// so that err can be set anywhere and then will be handled when we return
	var err error
	defer func() { handleError(c, err) }()

	paramBikeID := c.Params.ByName("id")

	bikeID := uuid.MustParse(paramBikeID)

	bike := &Bike{}
	unparsedBikeJSON, err := io.ReadAll(c.Request.Body)
	if err != nil {
		err = &invalidRequestError{err}
		return
	}

	err = json.Unmarshal(unparsedBikeJSON, bike)
	if err != nil {
		err = &invalidRequestError{err}
		return
	}

	err = s.ds.SetBike(bikeID, bike)
	if err != nil {
		return
	}
}

// getParts responds with information about all parts, with an optional category
func (s Service) getParts(c *gin.Context) {
	// we declare err here and then defer its handling
	// so that err can be set anywhere and then will be handled when wes return
	var err error
	defer func() { handleError(c, err) }()

	category := c.Params.ByName("category")
	parts, err := s.ds.GetParts(category)
	if err != nil {
		return
	}

	partsJSON, err := json.Marshal(parts)
	if err != nil {
		return
	}

	if _, err = c.Writer.Write(partsJSON); err != nil {
		return
	}
}

func handleError(c *gin.Context, err error) {
	if err == nil {
		c.Status(http.StatusOK)
		return
	}

	var body string
	if errors.Is(err, errorNotFound) {
		c.Status(http.StatusNotFound)
		body = err.Error()
	} else if errors.As(err, &invalidRequestError{}) {
		c.Status(http.StatusBadRequest)
		body = err.Error()
	} else {
		c.Status(http.StatusInternalServerError)

		// This is bad practice. Normally you would obfuscate internal server errors.
		// Writing the error to the response purely for demonstration and debugging.
		body = err.Error()
	}

	if _, err = c.Writer.Write([]byte(body)); err != nil {
		c.Status(http.StatusInternalServerError)
	}
}
