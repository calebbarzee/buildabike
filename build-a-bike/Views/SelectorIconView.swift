
import SwiftUI

struct SelectorIconView: View {
    @Binding var partTypeSelected: String
        var body: some View {
            VStack {
                Text(partTypeSelected)
                    .font(.title)
                GeometryReader { geometry in
                    ZStack {
                        BicycleIcon()
                            .fill(Color.gray)
                        SeatSelector()
                            .fill(Color.clear)
                            .contentShape(SeatSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Seat"
                            }
                        HandlebarSelector()
                            .fill(Color.clear)
                            .contentShape(HandlebarSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Handlebar"
                            }
                        FrameSelector()
                            .fill(Color.clear)
                            .contentShape(FrameSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Frame"
                            }
                        ForkSelector()
                            .fill(Color.clear)
                            .contentShape(ForkSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Fork"
                            }
                        WheelsSelector()
                            .fill(Color.clear)
                            .contentShape(WheelsSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Wheels"
                            }
                        DrivetrainSelector()
                            .fill(Color.clear)
                            .contentShape(DrivetrainSelector())
                            .onTapGesture {
                                self.partTypeSelected = "Drivetrain"
                            }
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
}
