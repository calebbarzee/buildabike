import Foundation
import SwiftUI

struct FindPartView: View {
    @Binding var bike: Bike
    @State private var searchQuery = ""
    @State private var partTypeSelected: BikePartType = .frame // Adjust to BikePartType
    @State private var isLoading = false

    let bikeParts: BikeParts = loadBikeParts() ?? BikeParts(frames: [], forks: [], headsets: [], wheels: [], tires: [], innerTubes: [], seatposts: [], handlebars: [], bottomBrackets: [], cranks: [], pedals: [])

    var body: some View {
        VStack {
            TextField("Search Parts", text: $searchQuery)
                .padding()
                .border(Color.gray, width: 1)
                .onChange(of: searchQuery, perform: filterParts)

            Picker("Select Part Type", selection: $partTypeSelected) {
                // Add Picker items for each part type
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if isLoading {
                ProgressView()
            } else {
                List {
                    Section {
                        ForEach(filteredParts(), id: \.id) { part in
                            Text(part.name)
                                .padding()
                                .onTapGesture {
                                    // Handle part selection
                                    addPartToBike(part: part)
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle("Find a Part for \(bike.name)")
    }

    func filterParts(_ query: String) {
        // Implement logic to filter parts based on searchQuery and partTypeSelected
    }

    func filteredParts() -> [BikePart] {
        // Implement logic to return filtered parts based on partTypeSelected and searchQuery
    }

    func addPartToBike(part: BikePart) {
        // Implement logic to add selected part to bike
    }
}
