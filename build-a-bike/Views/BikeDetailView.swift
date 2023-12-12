import SwiftUI


struct BikeDetailView: View {
    @Binding var bike: Bike
    
    var body: some View {
        VStack {
            TextField("Enter bike name", text: $bike.name)
                .font(.title)
                .padding()

            List(bike.parts ?? []) { part in
                Text(part.name)
            }

            Spacer()

            NavigationLink(destination: FindPartView(bike: $bike)) {
                Text("Find a Part")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            NavigationLink(destination: PhysicsCalcView(bike: bike)) {
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

// add http update method to change bike name
