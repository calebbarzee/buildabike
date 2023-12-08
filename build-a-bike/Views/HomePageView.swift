import SwiftUI

struct HomePageView: View {
    @State private var bikes: [Bike] = []
    @State private var selectedBike: Bike? = nil

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
                    
                    Button(action: {
                        let newBike = Bike(id: UUID(), name: "New Bike", parts: [])
                        bikes.append(newBike) 
                    }) {
                        Text("+")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
        }
        .onAppear {
            loadBikes { result in
                switch result {
                case .success(let loadedBikes):
                    self.bikes = loadedBikes
                case .failure(let error):
                    // Handle error here, e.g., show an alert
                    print("Error loading bikes: \(error)")
                }
            }
        }
    }
    func deleteBike(at offsets: IndexSet) {
        bikes.remove(atOffsets: offsets)
    }

}


#Preview {
    HomePageView()
}
