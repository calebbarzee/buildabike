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
                print(foundPart)
                return foundPart
            }
        }

        return nil
    }


    func addPartToBike() {
        if let selectedPartId = selectedPartId,
           let selectedPart = findPartById(selectedPartId) as? Part {
            print(selectedPart)
//part must have a key for what type of part it is
        }
    }
}
