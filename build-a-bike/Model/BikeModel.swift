// all float sizes represent mm
import Foundation

protocol PartProtocol: Decodable, Identifiable {
    var id: UUID { get }
    var name: String { get }
    var compatibilities: [String: [String]]? { get }
}

struct Bike: Decodable, Identifiable {
    let id: UUID
    var name: String
    var parts: [Part]
}

struct Part: Decodable, Identifiable {
    let id: UUID
    let name: String
    let compatibilities: [String: [String]]?
}

struct Range: Decodable {
    let min: Double?
    let max: Double?
}

struct Frame: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }

    let seatpostDiameter: Double?
    let bottomBracketType: String?
    let bottomBracketDiameter: Double?
    let headTubeDiameter: Double?
    let rearWheelDiameter: Double?
}

struct Fork: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let frontWheelDiameter: Double?
    let steeringTubeDiameter: Double?
    let armLength: Double?
    let suspensionType: String?
    let wheelMountType: String?
    let brakeMountType: String?
}

struct Headset: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let angle: Double?
    let length: Double?
    let handlebarDiameter: Range?
    let steeringTubeDiameter: Double?
}

struct Wheel: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let mountType: String?
    let diameter: Double?
    let width: Double?
}

struct Tire: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let thickness: Double?
    let diameter: Double?
    let width: Double?
    let treadType: String?
    let treadDepth: Double?
}

struct InnerTube: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let valveType: String?
    let thickness: Double?
    let diameter: Double?
    let width: Double?
    let pressure: Range?
}

struct SeatPost: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let diameter: Double?
}

struct Handlebar: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let width: Double?
    let diameter: Double?
}

struct BottomBracket: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let diameter: Double?
    let threadSpacing: Double?
}

struct Crank: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let armWidth: Double?
    let armLength: Double?
    let armDepth: Double?
}

struct Pedal: Decodable, PartProtocol {
    let part: Part
    var id: UUID { part.id }
    var name: String { part.name }
    var compatibilities: [String: [String]]? { part.compatibilities }
    
    let baseWidth: Double?
    let baseLength: Double?
    let gripType: String?
    let diameter: Double?
    let threadSpacing: Double?
}
