package api

import "github.com/google/uuid"

// Bike represents a bike with a UUID, name, and array of parts
type Bike struct {
	UUID  uuid.UUID
	Name  string
	Parts []Identifiable
}

type Identifiable interface {
	GetID() string
	GetName() string
	GetType() string
	GetCompatible(category string) []string
}

var _ Identifiable = (*Part)(nil)

type CategorizedTypes map[string]Types
type Types []string

// Part is a general struct for bike parts
type Part struct {
	ID              string
	Name            string
	Type            string
	Compatibilities CategorizedTypes
}

func (p Part) GetID() string                          { return p.ID }
func (p Part) GetName() string                        { return p.Name }
func (p Part) GetType() string                        { return p.Type }
func (p Part) GetCompatible(category string) []string { return p.Compatibilities[category] }

type Range struct {
	Min float64
	Max float64
}

// Frame represents a bike frame
type Frame struct {
	Part
	SeatpostDiameter      float64
	BottomBracketType     string
	BottomBracketDiameter float64
	HeadTubeDiameter      float64
	RearWheelDiameter     float64
}

// Fork represents a bike fork
type Fork struct {
	Part
	FrontWheelDiameter   float64
	SteeringTubeDiameter float64
	ArmLength            float64
	SuspensionType       string
	WheelMountType       string
	BrakeMountType       string
}

// Headsets represents a bike headset
type Headsets struct {
	Part
	Angle                float64
	Length               float64
	HandlebarDiameter    Range
	SteeringTubeDiameter float64
}

// Wheel represents a single bike wheel
type Wheel struct {
	Part
	MountType string
	Diameter  float64
	Width     float64
}

// Tire represents a single bike tire
type Tire struct {
	Part
	Thickness  float64
	Diameter   float64
	Width      float64
	TreadType  string
	TreadDepth float64
}

// InnerTube represents a single bike innerTube
type InnerTube struct {
	Part
	ValveType string
	Thickness float64
	Diameter  float64
	Width     float64
	Preasure  Range
}

// SeatPost represents a bike seatPost
type SeatPost struct {
	Part
	Diameter float64
}

// Handlebar represents a full bike handlebar
type Handlebar struct {
	Part
	Width    float64
	Diameter float64
}

// BottomBracket represents a bike bottomBracket
type BottomBracket struct {
	Part
	Diameter      float64
	ThreadSpacing float64
}

// Crank represents a bike crank
type Crank struct {
	Part
	ArmWidth  float64
	ArmLength float64
	ArmDepth  float64
}

// Pedal represents a pair of bike pedals
type Pedal struct {
	Part
	BaseWidth     float64
	BaseLength    float64
	GripType      string
	Diameter      float64
	ThreadSpacing float64
}
