import SwiftUI


struct BikeDetailView: View {
    var bike: Bike

    var body: some View {
        VStack {
            Text(bike.name)
                .font(.title)
                .padding()

            List(bike.parts) { part in
                Text(part.name)
            }

            Spacer()

            NavigationLink(destination: FindPartView(bike: bike)) {
                Text("Find a Part")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            NavigationLink(destination: PhysicsCalculationsView(bike: bike)) {
                Text("Physics Calculations")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Bike Details")
    }
}
