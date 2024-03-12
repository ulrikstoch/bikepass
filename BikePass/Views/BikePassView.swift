//
//  BikePassView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 13/02/2024.
//

import SwiftUI
import CoreMotion
import CoreHaptics
import ConfettiSwiftUI
import Combine
//
//
class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()

    @Published var pitch: Double = 0 // Tilt forward/backward
    @Published var roll: Double = 0 // Tilt left/right

    init() {
        startMotionUpdates()
    }

    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let motion = motion, error == nil else { return }
                self?.pitch = motion.attitude.pitch
                self?.roll = motion.attitude.roll
            }
        }
    }
}
//
//class MotionManager: ObservableObject {
//    private var motionManager = CMMotionManager()
//    @Published var roll: Double = 0.0
//    @Published var pitch: Double = 0.0
//
//    init() {
//        startMotionUpdates()
//    }
//
//    func startMotionUpdates() {
//        if motionManager.isGyroAvailable {
//            motionManager.gyroUpdateInterval = 1.0 / 60.0
//            motionManager.startGyroUpdates(to: .main) { [weak self] (gyroData, error) in
//                guard let data = gyroData else { return }
//                self?.roll = data.rotationRate.x
//                self?.pitch = data.rotationRate.y
//            }
//        }
//    }
//}

struct BikePassView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var motionManager = MotionManager()
    @State private var dragState = CGSize.zero
    @State private var isTouching: Bool = false // Tracks whether the user is currently touching the screen
    @State private var rotationAngleX: Double = 0
    @State private var rotationAngleY: Double = 0
    @State private var isFirstTime = !UserDefaults.standard.bool(forKey: "hasSeenConfetti")
//    @State private var scale: CGFloat = 0.25  // Initial scale
//    @State private var opacity: Double = 0    // Initial opacity
    @State private var scale: CGFloat = 1.0  // Initial scale
    @State private var opacity: Double = 1.0    // Initial opacity

    @ObservedObject var viewModel: QuizViewModel
    
    let bikePassID: String
    let issueDate: String
    
    private var dynamicGradient: LinearGradient {
            LinearGradient(
                gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                startPoint: UnitPoint(x: 0.5 - (motionManager.roll / 50), y: 0.5 - (motionManager.pitch / 50)),
                endPoint: UnitPoint(x: 0.5 + (motionManager.roll / 50), y: 0.5 + (motionManager.pitch / 50))
            )
        }
       
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
                
                
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {

                            Text("CPH BikePass")
                                .fontWeight(.semibold)
                                .foregroundStyle(dynamicGradient)
                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                                
                            Text(bikePassID)
                                .fontWeight(.regular)
                                .foregroundColor(Color(red: 0.57, green: 0.57, blue: 0.57))
                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                            

                        }

                        Spacer()
                        Image("badge")
                    }
                    
                    Image("center_circle")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    HStack() {
                        VStack(alignment: .leading) {
                            
                            Text(viewModel.userName)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
//                                .lineLimit(2)
                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                            Text("Valid from \(issueDate)")
                                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                        }
                        Spacer()
                    }
                    
                    
                }
                
                
                
                .padding([.leading, .bottom, .trailing], 24.0)
                .padding(.top, 17.0)
                
                .foregroundColor(.clear)
                .frame(height: 500)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.9, green: 0.9, blue: 0.9), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.78, green: 0.8, blue: 0.82), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .scaleEffect(scale)     // Apply scaling
                                .opacity(opacity)       // Apply opacity
                                .onAppear {
                                    if isFirstTime {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                            scale = 1.0  // End scale
                                            opacity = 1.0  // End opacity
                                        }
                                    }
                                }
                .rotation3DEffect(Angle(degrees: rotationAngleX), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(Angle(degrees: rotationAngleY), axis: (x: 0, y: 1, z: 0))
                .gesture(
                    DragGesture(minimumDistance: 0)
                    
                        .onChanged { value in
                            withAnimation {
                                let cardSize = geometry.size
                                let tapLocation = value.location
                                
                                // Calculate offsets from the center
                                let offsetX = (tapLocation.x - cardSize.width / 2) / (cardSize.width / 2)
                                let offsetY = (tapLocation.y - cardSize.height / 2.5) / (cardSize.height / 2.5)
                                
                                // Adjust the tilt based on the tap location
                                // Sensitivity adjustments might be necessary
                                self.rotationAngleX = Double(-offsetY * 6) // Tilt vertically
                                self.rotationAngleY = Double(offsetX * 6) // Tilt horizontally
                            }
                            
                        }
                        .onEnded { _ in
                            withAnimation {
                                self.rotationAngleX = 0
                                self.rotationAngleY = 0
                            }
                        }
                )
                .shadow(color: .black.opacity(0.17), radius: 1.20376, x: 0, y: 0.99621)
                .shadow(color: .black.opacity(0.12), radius: 2.89279, x: 0, y: 2.39404)
                .shadow(color: .black.opacity(0.1), radius: 5.44688, x: 0, y: 4.50776)
                .shadow(color: .black.opacity(0.09), radius: 9.71629, x: 0, y: 8.04107)
                .shadow(color: .black.opacity(0.07), radius: 18.17326, x: 0, y: 15.03994)
                .shadow(color: .black.opacity(0.05), radius: 43.5, x: 0, y: 36)
                .padding(.horizontal, 24)
                
            }
        }
    }
}


struct BikePassView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QuizViewModel()
        viewModel.userName = "Ulrik Stoch Jensen"
        return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
    }
}

