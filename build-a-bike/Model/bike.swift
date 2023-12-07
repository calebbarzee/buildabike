
import Foundation

struct Bike: Identifiable {
    var id = UUID()
    var name: String
    var parts: [Part]

}

struct Part: Identifiable {
    var id: UUID
    var name: String
    var type: String
}
