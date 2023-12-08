// all float sizes represent mm
import Foundation

struct Bike: Decodable, Identifiable {
    let id: UUID
    var name: String
    var parts: [Part]
}

struct Part: Decodable, Identifiable {
    let id: UUID
    let name: String
    let type: String
    let compatibilities: [String: [String]]
}

struct Range: Decodable {
    let min: Double?
    let max: Double?
}

struct Frame: Decodable {
    let part: Part
    let seatpostDiameter: Double?
    let bottomBracketType: String?
    let bottomBracketDiameter: Double?
    let headTubeDiameter: Double?
    let rearWheelDiameter: Double?
}

struct Fork: Decodable {
    let part: Part
    let frontWheelDiameter: Double?
    let steeringTubeDiameter: Double?
    let armLength: Double?
    let suspensionType: String?
    let wheelMountType: String?
    let brakeMountType: String?
}

struct Headset: Decodable {
    let part: Part
    let angle: Double?
    let length: Double?
    let handlebarDiameter: Range?
    let steeringTubeDiameter: Double?
}

struct Wheel: Decodable {
    let part: Part
    let mountType: String?
    let diameter: Double?
    let width: Double?
}

struct Tire: Decodable {
    let part: Part
    let thickness: Double?
    let diameter: Double?
    let width: Double?
    let treadType: String?
    let treadDepth: Double?
}

struct InnerTube: Decodable {
    let part: Part
    let valveType: String?
    let thickness: Double?
    let diameter: Double?
    let width: Double?
    let pressure: Range?
}

struct SeatPost: Decodable {
    let part: Part
    let diameter: Double?
}

struct Handlebar: Decodable {
    let part: Part
    let width: Double?
    let diameter: Double?
}

struct BottomBracket: Decodable {
    let part: Part
    let diameter: Double?
    let threadSpacing: Double?
}

struct Crank: Decodable {
    let part: Part
    let armWidth: Double?
    let armLength: Double?
    let armDepth: Double?
}

struct Pedal: Decodable {
    let part: Part
    let baseWidth: Double?
    let baseLength: Double?
    let gripType: String?
    let diameter: Double?
    let threadSpacing: Double?
}
