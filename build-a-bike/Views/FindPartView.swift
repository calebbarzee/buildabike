import SwiftUI

struct FindPartView: View {
    var bike: Bike
    @State private var searchQuery = ""
    @State private var partTypeSelected: String = "None" // New State for part selection
    @State private var filteredParts: [String: [Part]] = [:]

    var body: some View {
        VStack {
            TextField("Search Parts", text: $searchQuery)
                .padding()
                .border(Color.gray, width: 1)
                .onChange(of: searchQuery, perform: filterParts)

            SelectorIconView(partTypeSelected: $partTypeSelected)
                .onChange(of: partTypeSelected) { _ in filterParts(searchQuery) }

            List {
                ForEach(filteredParts.keys.sorted(), id: \.self) { category in
                    if partTypeSelected == "None" || partTypeSelected == category {
                        Section(header: Text(category)) {
                            ForEach(filteredParts[category] ?? []) { part in
                                Text(part.name)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Find a Part for \(bike.name)")
        .onAppear(perform: { filterParts(searchQuery) })
    }

    func filterParts(_ query: String) {
        let filtered = bike.parts.filter { part in
            (query.isEmpty || part.name.contains(query)) &&
            (partTypeSelected == "None" || partTypeSelected == part.type)
        }
        filteredParts = Dictionary(grouping: filtered, by: { $0.type })
    }
}
