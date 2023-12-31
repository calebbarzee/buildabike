import SwiftUI


struct BikeDetailView: View {
    @Binding var bike: Bike
    @State private var partData: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter bike name", text: $bike.name)
                .font(.title)
                .padding()
                .onSubmit {updateBike()}
            
        List(bike.parts, id: \.self) { part in
                       PartView(partId: part)
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
}

struct PartView: View {
    let partId: UUID
    @State private var partData: String = "Loading..."

    var body: some View {
        Text(partData)
            .onAppear {
                loadPartData()
            }
    }

    func loadPartData() {
        // Call your resolvePartData function here
        resolvePartData(partId: partId) { result in
            switch result {
            case .success(let part):
                self.partData = String(describing: part)
            case .failure(let error):
                self.partData = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    // takes an id and returns all data for part
    func resolvePartData(partId: UUID, completion: @escaping (Result<(any PartProtocol), Error>) -> Void) {
        findPartById(partId, completion: completion)
    }
    
    func findPartById(_ id: UUID, completion: @escaping (Result<any PartProtocol, Error>) -> Void) {
        loadBikeParts { result in
            switch result {
            case .success(let parts):
                
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
                        completion(.success(foundPart))
                        return
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadBikeParts(completion: @escaping (Result<BicycleComponents, Error>) -> Void) {
        fetchParts(from: "\(localIP)/api/v1/parts") { result in
            switch result {
            case .success(let loadedParts):
                completion(.success(loadedParts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
