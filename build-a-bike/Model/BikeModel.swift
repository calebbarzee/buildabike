// all float sizes represent mm
import Foundation

struct Bike: Codable, Identifiable {
   let id: UUID
   var name: String
    var parts: [UUID]?
}

struct BicycleComponents: Decodable {
    let frames: [Frame]
    let forks: [Fork]
    let headsets: [Headset]
    let wheels: [Wheel]
    let tires: [Tire]
    let innertubes: [Innertube]
    let seatposts: [Seatpost]
    let handlebars: [Handlebar]
    let bottomBrackets: [BottomBracket]
    let cranks: [Crank]
    let pedals: [Pedal]
}

struct Part: Codable, Identifiable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
}

protocol PartProtocol: Decodable, Identifiable {
   var id: UUID { get }
   var name: String { get }
   var compatibilities: [String: [String]]? { get }
}

struct Range: Decodable {
   let min: Double?
   let max: Double?
}

struct Frame: Decodable, PartProtocol {
   var id: UUID
   var name: String
   var compatibilities: [String: [String]]?
    let type: String?
   let seatpostDiameter: Double?
   let bottomBracketType: String?
   let bottomBracketDiameter: Double?
   let headTubeDiameter: Double?
   let rearWheelDiameter: Double?
}

struct Fork: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let frontWheelDiameter: Double?
   let steeringTubeDiameter: Double?
   let armLength: Double?
   let suspensionType: String?
   let wheelMountType: String?
   let brakeMountType: String?
}

struct Headset: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let angle: Double?
   let length: Double?
   let handlebarDiameter: Range?
   let steeringTubeDiameter: Double?
}

struct Wheel: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let mountType: String?
   let diameter: Double?
   let width: Double?
}

struct Tire: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let thickness: Double?
   let diameter: Double?
   let width: Double?
   let treadType: String?
   let treadDepth: Double?
}

struct Innertube: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let valveType: String?
   let thickness: Double?
   let diameter: Double?
   let width: Double?
   let pressure: Range?
}

struct Seatpost: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let diameter: Double?
}

struct Handlebar: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let width: Double?
   let diameter: Double?
}

struct BottomBracket: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let diameter: Double?
   let threadSpacing: Double?
}

struct Crank: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
   let type: String?
   let armWidth: Double?
   let armLength: Double?
   let armDepth: Double?
}

struct Pedal: Decodable, PartProtocol {
    var id: UUID
    var name: String
    var compatibilities: [String: [String]]?
    let type: String?
   let baseWidth: Double?
   let baseLength: Double?
   let gripType: String?
   let diameter: Double?
   let threadSpacing: Double?
}
