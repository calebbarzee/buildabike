import Foundation

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



// all float sizes represent mm

protocol Named {
    var name: String { get }
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
        let type: String
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
        let type: String
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
        let type: String
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
        let type: String
        let materialType: String
        let boltType: String
        let diameter: Float
        let width: Float
        let compatibleTireTypes: [String]
    }
    
    struct Tire: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let type: String
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
        let type: String
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
        let type: String
        let materialType: String
        let diameter: Float
    }
    
    struct Handlebar: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let type: String
        let materialType: String
        let width: Float
        let diameter: Float
    }
    
    struct BottomBracket: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let type: String
        let diameter: Float
        let threadSpacing: Float
    }
    
    struct Crank: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let type: String
        let materialType: String
        let armWidth: Float
        let armLength: Float
        let armDepth: Float
    }
    
    struct Pedal: Decodable, Identifiable, Named{
        let id = UUID()
        let name: String
        let type: String
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
