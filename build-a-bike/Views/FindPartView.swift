import Foundation
import SwiftUI

// Define an enumeration for Bike Part Types
enum BikePartType: String, CaseIterable, Identifiable {
    case all, frame, fork, headset, wheel, tire, innerTube, seatpost, handlebar, bottomBracket, crank, pedal
    
    var id: String { self.rawValue }
}

struct PartCategory: Identifiable {
    let id = UUID()
    let type: BikePartType
    var parts: [any PartProtocol]
}

struct FindPartView: View {
    @Binding var bike: Bike
    @State private var searchQuery = ""
    @State private var partTypeSelected: BikePartType = .all
    @State private var parts: BicycleComponents = BicycleComponents(
        frames: [],
        forks: [],
        headsets: [],
        wheels: [],
        tires: [],
        innertubes: [],
        seatposts: [],
        handlebars: [],
        bottomBrackets: [],
        cranks: [],
        pedals: []
    )
    @State private var isLoading = false
    @State private var selectedPartId: UUID? = nil

    var body: some View {
        VStack {
            TextField("Search Parts", text: $searchQuery)
                .padding()
                .border(Color.gray, width: 1)
            //                         .onChange(of: searchQuery, perform: filterParts)
            
            Menu {
                Picker("Select Part Type", selection: $partTypeSelected) {
                    ForEach(BikePartType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
            } label: {
                Label("Select Part Type: \(partTypeSelected.rawValue.capitalized)", systemImage: "bicycle")
            }
            .padding()
            
            if isLoading {
                ProgressView()
            } else {
                List(filterParts(), id: \.id) { category in
                    Section(header: Text(category.type.rawValue.capitalized)) {
                        ForEach(category.parts, id: \.id) { part in
                            HStack {
                                Text(part.name)
                                Spacer()
                                if selectedPartId == part.id {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .padding()
                            .background(selectedPartId == part.id ? Color.gray.opacity(0.3) : Color.clear)
                            .onTapGesture {
                                self.selectedPartId = part.id
                                }
                            }
                        }
                    }
                .navigationTitle("Find a Part for \(bike.name)")
                Button("Add to \(bike.name)") {
                    addPartToBike()
                }
                .padding()
                .border(Color.blue, width: 2)
                .cornerRadius(3)
            }
        }
        .onAppear {
            loadBikeParts()
        }
    }
    func loadBikeParts() {
        isLoading = true
        fetchParts(from: "\(localIP)/api/v1/parts") { result in
            switch result {
            case .success(let loadedParts):
                self.parts = loadedParts
//                print(self.parts)
                isLoading = false
            case .failure(let error):
                print("Error loading bikes: \(error)")
                isLoading = false
            }
        }
    }

    func filterParts() -> [PartCategory] {
        var categories: [PartCategory] = []

        // Helper function to create a PartCategory
        func createCategory(for type: BikePartType, with parts: [any PartProtocol]) {
            var filteredParts = parts.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            if searchQuery.isEmpty {
                        // If search query is empty, include all parts
                        filteredParts = parts
                    } else {
                        // Otherwise, filter parts based on the search query
                        filteredParts = parts.filter {
                            $0.name.lowercased().contains(searchQuery.lowercased())
                        }
                    }
            if !filteredParts.isEmpty {
                categories.append(PartCategory(type: type, parts: filteredParts))
            }
        }

        if partTypeSelected == .all {
            // Aggregate all parts into a single category
            var allParts: [any PartProtocol] = []
            allParts.append(contentsOf: parts.frames)
            allParts.append(contentsOf: parts.forks)
            allParts.append(contentsOf: parts.headsets)
            allParts.append(contentsOf: parts.wheels)
            allParts.append(contentsOf: parts.tires)
            allParts.append(contentsOf: parts.innertubes)
            allParts.append(contentsOf: parts.seatposts)
            allParts.append(contentsOf: parts.handlebars)
            allParts.append(contentsOf: parts.bottomBrackets)
            allParts.append(contentsOf: parts.cranks)
            allParts.append(contentsOf: parts.pedals)

            createCategory(for: .all, with: allParts)
        } else {
            // Create categories for each specific part type
            switch partTypeSelected {
            case .frame:
                createCategory(for: .frame, with: parts.frames)
            case .fork:
                createCategory(for: .fork, with: parts.forks)
            case .headset:
                createCategory(for: .headset, with: parts.headsets)
            case .wheel:
                createCategory(for: .wheel, with: parts.wheels)
            case .tire:
                createCategory(for: .tire, with: parts.tires)
            case .innerTube:
                createCategory(for: .innerTube, with: parts.innertubes)
            case .seatpost:
                createCategory(for: .seatpost, with: parts.seatposts)
            case .handlebar:
                createCategory(for: .handlebar, with: parts.handlebars)
            case .bottomBracket:
                createCategory(for: .bottomBracket, with: parts.bottomBrackets)
            case .crank:
                createCategory(for: .crank, with: parts.cranks)
            case .pedal:
                createCategory(for: .pedal, with: parts.pedals)
            default:
                break
            }
        }

        return categories
    }

    func findPartById(_ id: UUID) -> (any PartProtocol)? {
        let categories = [
            parts.frames as [any PartProtocol],
            parts.forks as [any PartProtocol],
            parts.headsets as [any PartProtocol],
            parts.wheels as [any PartProtocol],
            parts.tires as [any PartProtocol],
            parts.innertubes as [any PartProtocol],
            parts.seatposts as [any PartProtocol],
            parts.handlebars as [any PartProtocol],
            parts.bottomBrackets as [any PartProtocol],
            parts.cranks as [any PartProtocol],
            parts.pedals as [any PartProtocol]
        ]

        for category in categories {
            if let foundPart = category.first(where: { $0.id == id }) {
//                print(foundPart)
                return foundPart
            }
        }

        return nil
    }


//    func addPartToBike() {
//        if let selectedPartId = selectedPartId {
//            bike.parts.append(selectedPartId)
//            // print(selectedPartId)
//        }
//        updateBike()
//    }
    
    func updateBike() {
        let url = "\(localIP)/api/v1/bike/\(bike.id)"
        postBike(bike, to: url) { result in
            switch result {
            case .success(let response):
                print("Post successful: \(response)")
            case .failure(let error):
                print("Error posting bike: \(error)")
            }
        }
    }
    
    func addPartToBike() {
        guard let selectedPartId = selectedPartId,
              let selectedPart: any PartProtocol = findPartById(selectedPartId) else { return }

        let selectedPartType = String(describing: type(of: selectedPart))

        // Check if a part of the same type already exists on the bike
        if bike.parts.contains(where: { partId in
            guard let part: any PartProtocol = findPartById(partId) else { return false }
            return String(describing: type(of: part)) == selectedPartType
        }) {
            print("A part of type \(selectedPartType) is already present on the bike.")
            return
        }

        var isCompatible = true

        // Iterate through the bike parts to check for compatibility
        for bikePartId in bike.parts {
            guard let bikePart: any PartProtocol = findPartById(bikePartId) else { continue }

            // Determine the part connection based on the type of the selected part
            var connectionType: String?
            switch selectedPartType {
            case "Pedal":
                connectionType = "crank"
            case "Crank":
                connectionType = "bottomBracket"
            case "BottomBracket":
                connectionType = "frame"
            case "Fork":
                connectionType = "frame"
            case "Wheel":
                connectionType = "fork"
            case "Headset":
                connectionType = "fork"
            case "Handlebar":
                connectionType = "headset"
            case "Tire":
                connectionType = "wheel"
            case "Innertube":
                connectionType = "tire"
            case "Seatpost":
                connectionType = "frame"
            default:
                connectionType = nil
            }

            // If the type of the bike part matches the connection type, check for compatibility
            if String(describing: type(of: bikePart)).lowercased() == connectionType?.lowercased() {
                if let connectionType = connectionType {
                    let compatibleIds = selectedPart.compatibilities[connectionType]
                    isCompatible = compatibleIds!.contains(bikePartId.uuidString.lowercased()x)
                    if !isCompatible { break }
                }
            }
        }

        if isCompatible {
            bike.parts.append(selectedPartId)
            updateBike()
        } else {
            // Handle the case where the part is not compatible
            print("Selected part is not compatible with the current bike configuration.")
        }
    }


}
