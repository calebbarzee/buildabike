
import SwiftUI

struct SelectorIconView: View {
    @Binding var partTypeSelected: String
        var body: some View {
            VStack {
                Text(partTypeSelected)
                    .font(.title)
                GeometryReader { geometry in
                    ZStack {
                        Bicycle()
                            .fill(Color.gray)
                        Seat()
                            .fill(Color.clear)
                            .contentShape(Seat())
                            .onTapGesture {
                                self.partTypeSelected = "Seat"
                            }
                        Handlebar()
                            .fill(Color.clear)
                            .contentShape(Handlebar())
                            .onTapGesture {
                                self.partTypeSelected = "Handlebar"
                            }
                        Frame()
                            .fill(Color.clear)
                            .contentShape(Frame())
                            .onTapGesture {
                                self.partTypeSelected = "Frame"
                            }
                        Fork()
                            .fill(Color.clear)
                            .contentShape(Fork())
                            .onTapGesture {
                                self.partTypeSelected = "Fork"
                            }
                        Wheels()
                            .fill(Color.clear)
                            .contentShape(Wheels())
                            .onTapGesture {
                                self.partTypeSelected = "Wheels"
                            }
                        Drivetrain()
                            .fill(Color.clear)
                            .contentShape(Drivetrain())
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
