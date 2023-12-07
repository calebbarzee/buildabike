package main

import "github.com/google/uuid"

// Part is a general struct for bike parts
type Part struct {
	ID           string
	Name         string
	Type         string
	MaterialType string
}

// Frame represents a bike frame with specific attributes
type Frame struct {
	Part
	SeatpostDiameter     float64
	BottomBracketType    string
	BottomBracketDiameter float64
	HeadTubeDiameter     float64
	RearWheelSize        string
}

// Fork represents a bike fork with specific attributes
type Fork struct {
	Part
	WheelSize           string
	WheelDiameter       float64
	SteeringTubeDiameter float64
	ArmLength           float64
	SuspensionType      string
	WheelMountType      string
	BrakeMountType      string
}

// And similarly for other specific parts like Headset, Wheel, Tire, etc.

// Bike represents a bike with a UUID, name, and array of parts
type Bike struct {
	UUID  uuid.UUID
	Name  string
	Parts []Part
}

func main() {
	// Example of how to use these structs
	var bike Bike
	bike.UUID = uuid.New()
	bike.Name = "Mountain Master"
	bike.Parts = []Part{
		Frame{...}, // You would fill in the details here
		Fork{...},  // and for other parts
		// etc.
	}

	// Use the bike object as needed
}

