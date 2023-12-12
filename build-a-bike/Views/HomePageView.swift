import SwiftUI

import SwiftUI

struct HomePageView: View {
    @State private var bikes: [Bike] = []

    var body: some View {
        VStack {
            NavigationStack {
                Spacer()
                Text("Welcome to BuildaBike!")
                    .font(.largeTitle)
                    .padding()
                List {
                    ForEach($bikes, id: \.id) { $bike in
                        NavigationLink(destination: BikeDetailView(bike: $bike)) {
                            Text(bike.name)
                        }
                    }
                    .onDelete(perform: deleteBike)

                    Button(action: addBike) {
                        Text("+")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
        .onAppear {
            fetchBikes(from: "\(localIP)/api/v1/bikes") { result in
                switch result {
                case .success(let loadedBikes):
                    self.bikes = loadedBikes
                case .failure(let error):
                    print("Error loading bikes: \(error)")
                }
            }
        }
    }

    func deleteBike(at offsets: IndexSet) {
        bikes.remove(atOffsets: offsets)
    }
    func addBike() {
        let newBike = Bike(id: UUID(), name: "New Bike", parts: [])
        let url = "\(localIP)/api/v1/bike/\(newBike.id)"
        postBike(newBike, to: url) { result in
            switch result {
            case .success(let response):
                print("Post successful: \(response)")
            case .failure(let error):
                print("Error posting bike: \(error)")
            }
        }
        bikes.append(newBike)
    }
}

#Preview {
    HomePageView()
}
