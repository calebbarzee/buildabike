import SwiftUI

struct HomePageView: View {
    @State private var bikes: [Bike] = []
    @State private var isAddingBike = false
    @State private var editingBikeID: UUID?

    var body: some View {
        VStack {
            NavigationStack {
                Spacer()
                Text("Welcome to BuildaBike!")
                    .font(.largeTitle)
                    .padding()
                List {
                    ForEach(bikes) { bike in
                        if editingBikeID == bike.id {
                            TextField("Enter bike name", text: Binding(
                                get: { bike.name },
                                set: { newName in
                                    if let index = bikes.firstIndex(where: { $0.id == bike.id }) {
                                        bikes[index].name = newName
                                    }
                                }
                            ))
                        } else {
                            // Using NavigationLink to navigate to the detail view
                            NavigationLink(destination: BikeDetailView(bike: bike)) {
                                Text(bike.name)
                            }
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
    }

    func deleteBike(at offsets: IndexSet) {
        bikes.remove(atOffsets: offsets)
    }

}

#Preview {
    HomePageView()
}
