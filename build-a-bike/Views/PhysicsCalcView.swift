import SwiftUI

// Bicycle Speed Calculation Function
func calculateBicycleSpeed(tireCircumference: Double, gearRatio: Double, cadence: Double) -> Double {
    return tireCircumference * gearRatio * cadence * 60 / 1000
}

struct PhysicsCalcView: View {
    var bike: Bike
    @State private var tireCircumference = ""
    @State private var chainringTeeth = ""
    @State private var sprocketTeeth = ""
    @State private var pedalRPM = ""
    
    var bicycleSpeed: Double {
        guard let tireCirc = Double(tireCircumference),
              let chainring = Int(chainringTeeth),
              let sprocket = Int(sprocketTeeth),
              let rpm = Double(pedalRPM),
              sprocket != 0 else { return 0 }
        
        let gearRatio = Double(chainring) / Double(sprocket)
        return calculateBicycleSpeed(tireCircumference: tireCirc, gearRatio: gearRatio, cadence: rpm)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Tire Circumference (m)", text: $tireCircumference)
                        .keyboardType(.decimalPad)
                    TextField("Chainring Teeth", text: $chainringTeeth)
                        .keyboardType(.numberPad)
                    TextField("Sprocket Teeth", text: $sprocketTeeth)
                        .keyboardType(.numberPad)
                    TextField("Pedal RPM / Cadence", text: $pedalRPM)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Result")) {
                    Text("Bicycle Speed: \(bicycleSpeed, specifier: "%.2f") km/h")
                }
            }
            .navigationBarTitle("Bicycle Speed Calculator")
        }
    }
}
