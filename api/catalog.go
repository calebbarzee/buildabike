package api

import (
	_ "embed"
	"encoding/json"
	"fmt"
)

const (
	CategoryFrames        = "frame"
	CategoryForks         = "fork"
	CategoryHeadSets      = "headSet"
	CategoryWheel         = "wheel"
	CategoryTire          = "tire"
	CategoryInnerTube     = "innerTube"
	CategorySeatPost      = "seatPost"
	CategoryHandleBar     = "handleBar"
	CategoryBottomBracket = "bottomBracket"
	CategoryCrank         = "crank"
	CategoryPedal         = "pedal"
)

//go:embed Resources/bikeParts.json
var unparsedBikePartsJSON []byte

type Catalog struct {
	Frames         []Frame         `json:"frames,omitempty"`
	Forks          []Fork          `json:"forks,omitempty"`
	HeadSets       []Headset       `json:"headsets,omitempty"`
	Wheels         []Wheel         `json:"wheels,omitempty"`
	Tires          []Tire          `json:"tires,omitempty"`
	InnerTubes     []InnerTube     `json:"innertubes,omitempty"`
	SeatPosts      []SeatPost      `json:"seatposts,omitempty"`
	Handlebars     []Handlebar     `json:"handlebars,omitempty"`
	BottomBrackets []BottomBracket `json:"bottomBrackets,omitempty"`
	Cranks         []Crank         `json:"cranks,omitempty"`
	Pedals         []Pedal         `json:"pedals,omitempty"`
}

func NewCatalog() (*Catalog, error) {
	c := &Catalog{}
	err := json.Unmarshal(unparsedBikePartsJSON, c)
	if err != nil {
		return nil, fmt.Errorf("could not create new catalog %w", err)
	}
	return c, nil
}

// GetParts returns a catalog containing the requested parts category
// If there is no category, the whole catalog is returned
// If there is an invalid category, nil is returned
func (c Catalog) GetParts(category string) *Catalog {
	switch category {
	case CategoryFrames:
		return &Catalog{
			Frames: c.Frames,
		}
	case CategoryForks:
		return &Catalog{
			Forks: c.Forks,
		}
	case CategoryHeadSets:
		return &Catalog{
			HeadSets: c.HeadSets,
		}
	case CategoryWheel:
		return &Catalog{
			Wheels: c.Wheels,
		}
	case CategoryTire:
		return &Catalog{
			Tires: c.Tires,
		}
	case CategoryInnerTube:
		return &Catalog{
			InnerTubes: c.InnerTubes,
		}
	case CategorySeatPost:
		return &Catalog{
			SeatPosts: c.SeatPosts,
		}
	case CategoryHandleBar:
		return &Catalog{
			Handlebars: c.Handlebars,
		}
	case CategoryBottomBracket:
		return &Catalog{
			BottomBrackets: c.BottomBrackets,
		}
	case CategoryCrank:
		return &Catalog{
			Cranks: c.Cranks,
		}
	case CategoryPedal:
		return &Catalog{
			Pedals: c.Pedals,
		}
	case "":
		return &c
	default:
		return nil
	}
}
