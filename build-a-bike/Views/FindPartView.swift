import SwiftUI

struct FindPartView: View {
    var bike: Bike
    @State private var parts: [Part] = []
    @State private var searchQuery = ""
    @State private var partTypeSelected: String = "None"
    @State private var filteredParts: [String: [Part]] = [:]
    @State private var isLoading = false // Loading state

    var body: some View {
        VStack {
            TextField("Search Parts", text: $searchQuery)
                .padding()
                .border(Color.gray, width: 1)
                .onChange(of: searchQuery, perform: filterParts)

            SelectorIconView(partTypeSelected: $partTypeSelected)
                .onChange(of: partTypeSelected) { _ in filterParts(searchQuery) }

            if isLoading {
                ProgressView()
            } else {
                List {
                    if filteredParts.isEmpty {
                        Text("No parts available").foregroundColor(.gray)
                    } else {
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
            }
        }
        .navigationTitle("Find a Part for \(bike.name)")
        .onAppear {
            isLoading = true
            loadBikeParts { result in
                isLoading = false
                switch result {
                case .success(let loadedParts):
                    self.parts = loadedParts
                    self.filterParts(self.searchQuery)
                case .failure(let error):
                    print("Error loading parts: \(error)")
                    // Implement more sophisticated error handling here
                }
            }
        }
    }

    func filterParts(_ query: String) {
        let filtered = parts.filter { part in
            (query.isEmpty || part.name.lowercased().contains(query.lowercased()))
//            && (partTypeSelected == "None" || partTypeSelected == part.type)
        }
//        filteredParts = Dictionary(grouping: filtered, by: { $0.type })
    }
}
