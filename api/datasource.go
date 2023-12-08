package api

import (
	"fmt"

	"github.com/google/uuid"
)

var _ DataSource = (*LocalDataSource)(nil)

type LocalDataSource struct {
	catalog Catalog
	bikes   map[uuid.UUID]*Bike
}

func NewLocalDataSource() (*LocalDataSource, error) {
	c, err := NewCatalog()
	if err != nil {
		return nil, fmt.Errorf("could not create new LocalDataSource %w", err)
	}
	return &LocalDataSource{
		catalog: *c,
	}, nil
}

func (ds LocalDataSource) GetBike(id uuid.UUID) (*Bike, error) {
	bike, ok := ds.bikes[id]
	if !ok {
		return nil, errorBikeNotFound
	}
	return bike, nil
}

func (ds *LocalDataSource) SetBike(id uuid.UUID, bike *Bike) error {
	ds.bikes[id] = bike
	return nil
}

func (ds LocalDataSource) GetParts(category string) (*Catalog, error) {
	catalog := ds.catalog.GetParts(category)
	if catalog == nil {
		return nil, errorCategoryNotFound
	}
	return catalog, nil
}
