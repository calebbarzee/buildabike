import Foundation

// all float sizes represent mm

protocol Named {
    var name: String { get }
}

struct Bike: Identifiable {
    let id: UUID
    var name: String
    var parts: [any BikePart]
}

// Enum to represent all bike part types
enum BikePartType {
    case frame, fork, headset, handlebar, bottomBracket, crank, pedal, seatpost, wheel, tire, innerTube
}

// Protocol for common bike part properties
protocol BikePart: Named & Identifiable {
    var type: BikePartType { get }
}

// Extend your existing BikeParts structs to conform to BikePart
extension BikeParts.Frame: BikePart {
    var type: BikePartType { .frame }
}
extension BikeParts.Fork: BikePart {
    var type: BikePartType { .fork }
}
extension BikeParts.Headset: BikePart {
    var type: BikePartType { .headset }
}
extension BikeParts.Wheel: BikePart {
    var type: BikePartType { .wheel }
}
extension BikeParts.Tire: BikePart {
    var type: BikePartType { .tire }
}
extension BikeParts.InnerTube: BikePart {
    var type: BikePartType { .innerTube }
}
extension BikeParts.Seatpost: BikePart {
    var type: BikePartType { .seatpost }
}
extension BikeParts.Handlebar: BikePart {
    var type: BikePartType { .handlebar }
}
extension BikeParts.BottomBracket: BikePart {
    var type: BikePartType { .bottomBracket }
}
extension BikeParts.Crank: BikePart {
    var type: BikePartType { .crank }
}
extension BikeParts.Pedal: BikePart {
    var type: BikePartType { .pedal }
}

struct BikeParts: Decodable {
    let frames: [Frame]
    let forks: [Fork]
    let headsets: [Headset]
    let wheels: [Wheel]
    let tires: [Tire]
    let innerTubes: [InnerTube]
    let seatposts: [Seatpost]
    let handlebars: [Handlebar]
    let bottomBrackets: [BottomBracket]
    let cranks: [Crank]
    let pedals: [Pedal]
    
    struct Frame: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let seatpostDiameter: Float
        let bottomBracketType: String
        let bottomBracketDiameter: Float
        let headTubeDiameter: Float
        let rearWheelSize: String
    }
    
    struct Fork: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let wheelSize: String
        let wheelDiameter: Float // recommended wheelSize
        let steeringTubeDiameter: Float
        let armLength: Float
        let suspensionType: String
        let wheelMountType: String
        let brakeMountType: String
    }
    
    struct Headset: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let angle: Float // angle of headset in radians
        let length: Float
        let handlebarDiameterMin: Float
        let handlebarDiameterMax: Float
        let steeringTubeDiameter: Float
    }
    
    struct Wheel: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let boltType: String
        let diameter: Float
        let width: Float
        let compatibleTireTypes: [String]
    }
    
    struct Tire: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let materialThickness: Float
        let diameter: Float
        let width: Float
        let treadType: String
        let treadDepth: Float
    }
    
    struct InnerTube: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let valveType: String
        let materialType: String
        let materialThickness: Float
        let diameter: Float
        let width: Float
        let pressureMin: Float // recommended pressure range
        let pressureMax: Float
    }
    
    struct Seatpost: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let diameter: Float
    }
    
    struct Handlebar: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let width: Float
        let diameter: Float
    }
    
    struct BottomBracket: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let diameter: Float
        let threadSpacing: Float
    }
    
    struct Crank: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let armWidth: Float
        let armLength: Float
        let armDepth: Float
    }
    
    struct Pedal: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let category: String
        let materialType: String
        let baseWidth: Float
        let baseLength: Float
        let gripType: String
        let diameter: Float
        let threadSpacing: Float
    }
}

func loadBikeParts() -> BikeParts? {
    if let url = Bundle.main.url(forResource: "bikeParts", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let bikeParts = try decoder.decode(BikeParts.self, from: data)
            return bikeParts
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    } else {
        print("Could not find bikeParts.json")
    }
    return nil
}
