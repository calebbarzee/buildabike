package api

import (
	"errors"
	"fmt"
)

type invalidRequestError struct {
	err error
}

func (e *invalidRequestError) Error() string {
	return fmt.Sprintf("bad input: %s", e.err.Error())
}

func (e *invalidRequestError) Unwrap() error {
	return e.err
}

var (
	errorNotFound         = errors.New("object not found")
	errorBikeNotFound     = fmt.Errorf("bikeID not found: %w", errorNotFound)
	errorCategoryNotFound = fmt.Errorf("category not found: %w", errorNotFound)
)
