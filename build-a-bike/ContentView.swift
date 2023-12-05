import SwiftUI

struct ContentView: View {
    @State private var selectedFrame: BikeParts.Frame? = nil
    @State private var selectedFork: BikeParts.Fork? = nil
    @State private var selectedHeadset: BikeParts.Headset? = nil
    @State private var selectedHandlebar: BikeParts.Handlebar? = nil
    @State private var selectedBottomBracket: BikeParts.BottomBracket? = nil
    @State private var selectedCrank: BikeParts.Crank? = nil
    @State private var selectedPedal: BikeParts.Pedal? = nil
    @State private var selectedSeatpost: BikeParts.Seatpost? = nil
    @State private var selectedWheel: BikeParts.Wheel? = nil
    @State private var selectedTire: BikeParts.Tire? = nil
    @State private var selectedInnerTube: BikeParts.InnerTube? = nil
    
    @State private var selectedPartType: String = "Frame"
    @State private var compatibilityResult: String = "Select parts to check compatibility"
    
    let bikeParts = loadBikeParts() ?? BikeParts(frames: [], forks: [], headsets: [], wheels: [], tires: [], innerTubes: [], seatposts: [], handlebars: [], bottomBrackets: [], cranks: [], pedals: [])
    
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Select Part Type", selection: $selectedPartType) {
                    Text("Frame").tag("Frame")
                    Text("Fork").tag("Fork")
                    Text("Headset").tag("Headset")
                    Text("Handlebar").tag("Handlebar")
                    Text("Bottom Bracket").tag("BottomBracket")
                    Text("Crank").tag("Crank")
                    Text("Pedal").tag("Pedal")
                    Text("Seatpost").tag("Seatpost")
                    Text("Wheel").tag("Wheel")
                    Text("Tire").tag("Tire")
                    Text("Inner Tube").tag("InnerTube")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                switch selectedPartType {
                case "Frame" : PartSelector(parts: bikeParts.frames, selectedPart: $selectedFrame)
                case "Fork" : PartSelector(parts: bikeParts.forks, selectedPart: $selectedFork)
                case "Headset" : PartSelector(parts: bikeParts.headsets, selectedPart: $selectedHeadset)
                case "Handlebar" : PartSelector(parts: bikeParts.handlebars, selectedPart: $selectedHandlebar)
                case "BottomBracket" : PartSelector(parts: bikeParts.bottomBrackets, selectedPart: $selectedBottomBracket)
                case "Crank" : PartSelector(parts: bikeParts.cranks, selectedPart: $selectedCrank)
                case "Pedal" : PartSelector(parts: bikeParts.pedals, selectedPart: $selectedPedal)
                case "Seatpost" : PartSelector(parts: bikeParts.seatposts, selectedPart: $selectedSeatpost)
                case "Wheel" : PartSelector(parts: bikeParts.wheels, selectedPart: $selectedWheel)
                case "Tire" : PartSelector(parts: bikeParts.tires, selectedPart: $selectedTire)
                case "InnerTube" : PartSelector(parts: bikeParts.innerTubes, selectedPart: $selectedInnerTube)
                default : PartSelector(parts: bikeParts.frames, selectedPart: $selectedFrame)
                }
                
                Button("Check Compatibility") {
                    checkCompatibility()
                }
                .padding()
                
                Text(compatibilityResult)
                    .padding()
                    .foregroundColor(.blue)
            }
        }
    }
    
    struct PartSelector<T: Named & Identifiable>: View {
        let parts: [T]
        @Binding var selectedPart: T?
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(parts) { part in
                            Text(part.name)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).stroke(selectedPart?.id == part.id ? Color.blue : Color.gray))
                                .onTapGesture {
                                    selectedPart = part
                                }
                        }
                    }
                    .padding()
                }
            }
        }
    }

    
    func checkCompatibility() {
        
        //    Wheel: width == Tire: width == InnerTube: width && Wheel: diameter == Tire: diameter == InnerTube: diameter
        //    Headset: steeringTubeDiameter == Fork: steeringTubeDiameter
        //    Headset: handlebarDiameterMin <= Handlebar: diameter && Headset: handlebarDiameterMax >= Handlebar: diameter
        var compatibilityFailures: [String] = []
        if let selectedFrame = selectedFrame, let selectedFork = selectedFork{
            if !bikeParts.isFrameForkCompatible(frame: selectedFrame, fork: selectedFork) {
                compatibilityFailures.append("Frame & Fork")
            }
        }
        if let selectedFrame = selectedFrame, let selectedWheel = selectedWheel {
            if !bikeParts.isFrameWheelCompatible(frame: selectedFrame, wheel: selectedWheel) {
                compatibilityFailures.append("Frame & Wheel")
            }
        }
        if let selectedFrame = selectedFrame, let selectedBottomBracket = selectedBottomBracket {
            if !bikeParts.isFrameBottomBracketCompatible(frame: selectedFrame, bottomBracket: selectedBottomBracket) {
                compatibilityFailures.append("Frame & Bottom Bracket")
            }
        }
        if let selectedFrame = selectedFrame, let selectedSeatpost = selectedSeatpost {
            if !bikeParts.isFrameSeatpostCompatible(frame: selectedFrame, seatpost: selectedSeatpost) {
                compatibilityFailures.append("Frame & Seatpost")
            }
        }
            var compatibilityResult: String = ""
                if compatibilityFailures.isEmpty {
            compatibilityResult = "All selected parts are compatible."
        }
        else {
            compatibilityResult = "The following parts are incompatible: " + compatibilityFailures.formatted()
        }
    }
}
