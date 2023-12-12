package api

import "github.com/google/uuid"

// Bike represents a bike with a UUID, name, and array of parts
type Bike struct {
	ID    uuid.UUID   `json:"id"`
	Name  string      `json:"name"`
	Parts []uuid.UUID `json:"parts"`
}

type Identifiable interface {
	GetID() uuid.UUID
	GetName() string
	GetType() string
	GetCompatible(category string) []string
}

var _ Identifiable = (*Part)(nil)

type CategorizedTypes map[string]Types
type Types []string

// Part is a general struct for bike parts
type Part struct {
	ID              uuid.UUID        `json:"id"`
	Name            string           `json:"name,omitempty"`
	Type            string           `json:"type,omitempty"`
	Compatibilities CategorizedTypes `json:"compatibilities"`
}

func (p Part) GetID() uuid.UUID                       { return p.ID }
func (p Part) GetName() string                        { return p.Name }
func (p Part) GetType() string                        { return p.Type }
func (p Part) GetCompatible(category string) []string { return p.Compatibilities[category] }

type Range struct {
	Min float64 `json:"min,omitempty"`
	Max float64 `json:"max,omitempty"`
}

// Frame represents a bike frame
type Frame struct {
	Part
	SeatpostDiameter      float64 `json:"seatpostDiameter,omitempty"`
	BottomBracketType     string  `json:"bottomBracketType,omitempty"`
	BottomBracketDiameter float64 `json:"bottomBracketDiameter,omitempty"`
	HeadTubeDiameter      float64 `json:"headTubeDiameter,omitempty"`
	RearWheelDiameter     float64 `json:"rearWheelDiameter,omitempty"`
}

// Fork represents a bike fork
type Fork struct {
	Part
	FrontWheelDiameter   float64 `json:"frontWheelDiameter,omitempty"`
	SteeringTubeDiameter float64 `json:"steeringTubeDiameter,omitempty"`
	ArmLength            float64 `json:"armLength,omitempty"`
	SuspensionType       string  `json:"suspensionType,omitempty"`
	WheelMountType       string  `json:"wheelMountType,omitempty"`
	BrakeMountType       string  `json:"brakeMountType,omitempty"`
}

// Headset represents a bike headset
type Headset struct {
	Part
	Angle                float64 `json:"angle,omitempty"`
	Length               float64 `json:"length,omitempty"`
	HandlebarDiameter    Range   `json:"handlebarDiameter,omitempty"`
	SteeringTubeDiameter float64 `json:"steeringTubeDiameter,omitempty"`
}

// Wheel represents a single bike wheel
type Wheel struct {
	Part
	MountType string  `json:"mountType,omitempty"`
	Diameter  float64 `json:"diameter,omitempty"`
	Width     float64 `json:"width,omitempty"`
}

// Tire represents a single bike tire
type Tire struct {
	Part
	Thickness  float64 `json:"thickness,omitempty"`
	Diameter   float64 `json:"diameter,omitempty"`
	Width      float64 `json:"width,omitempty"`
	TreadType  string  `json:"treadType,omitempty"`
	TreadDepth float64 `json:"treadDepth,omitempty"`
}

// InnerTube represents a single bike innerTube
type InnerTube struct {
	Part
	ValveType string  `json:"valveType,omitempty"`
	Thickness float64 `json:"thickness,omitempty"`
	Diameter  float64 `json:"diameter,omitempty"`
	Width     float64 `json:"width,omitempty"`
	Pressure  Range   `json:"pressure,omitempty"`
}

// SeatPost represents a bike seatPost
type SeatPost struct {
	Part
	Diameter float64 `json:"diameter,omitempty"`
}

// Handlebar represents a full bike handlebar
type Handlebar struct {
	Part
	Width    float64 `json:"width,omitempty"`
	Diameter float64 `json:"diameter,omitempty"`
}

// BottomBracket represents a bike bottomBracket
type BottomBracket struct {
	Part
	Diameter      float64 `json:"diameter,omitempty"`
	ThreadSpacing float64 `json:"threadSpacing,omitempty"`
}

// Crank represents a bike crank
type Crank struct {
	Part
	ArmWidth  float64 `json:"armWidth,omitempty"`
	ArmLength float64 `json:"armLength,omitempty"`
	ArmDepth  float64 `json:"armDepth,omitempty"`
}

// Pedal represents a pair of bike pedals
type Pedal struct {
	Part
	BaseWidth     float64 `json:"baseWidth,omitempty"`
	BaseLength    float64 `json:"baseLength,omitempty"`
	GripType      string  `json:"gripType,omitempty"`
	Diameter      float64 `json:"diameter,omitempty"`
	ThreadSpacing float64 `json:"threadSpacing,omitempty"`
}
