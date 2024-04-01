////
////  MiniBikePassView.swift
////  BikePass
//
//
////
////  BikePassView.swift
////  BikePass
////
////  Created by Ulrik Stoch Jensen on 13/02/2024.
////
//
//import SwiftUI
//import CoreMotion
//import CoreHaptics
//import ConfettiSwiftUI
//import Combine
//
////
////struct CircularTextView: View {
////    let text: String
////    @State private var rotationAngle: Double = 330
////
////    var body: some View {
////        GeometryReader { geometry in
////            ZStack {
////                ForEach(0..<text.count, id: \.self) { index in
////                    let character = Array(text)[index]
////                    Text(String(character))
////                        .position(x: geometry.size.width / 2, y: 67) // Adjust y to move the text up or down
////                        .rotationEffect(.degrees(Double(index) * 360 / Double(text.count)), anchor: .center)
////                }
////            }
////            .rotationEffect(.degrees(rotationAngle))
////            .onAppear {
////                withAnimation(Animation.linear(duration: 120).repeatForever(autoreverses: false)) {
////                    rotationAngle = -360
////                }
////            }
////        }
////    }
////}
//
//
//
////
////
//
//
//
//struct MiniBikePassView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @ObservedObject var motionManager = MotionManager()
//    @State private var dragState = CGSize.zero
//    @State private var isTouching: Bool = false // Tracks whether the user is currently touching the screen
//    //    @State private var rotationAngleX: Double = 0
//    //    @State private var rotationAngleY: Double = 0
//    @State private var isFirstTime = !UserDefaults.standard.bool(forKey: "hasSeenConfetti")
//    //    @State private var scale: CGFloat = 0.25  // Initial scale
//    //    @State private var opacity: Double = 0    // Initial opacity
//    //    @State private var verticalOffset: CGFloat = 600 // Start from off-screen below
//    @State private var rotationAngleX: Double = -50 // Example starting angle
//    @State private var rotationAngleY: Double = 0 // Example starting angle
//    @State private var hapticEngine: CHHapticEngine?
//    @State private var confettiCounter = 0
//    @State private var highlightPosition = CGPoint.zero
//    
//    
//    
//    //
//    //    @ObservedObject var viewModel: QuizViewModel
//    //
//    //    let bikePassID: String
//    //    let issueDate: String
//    //
//    //
//    
//    private var dynamicGradient: LinearGradient {
//        LinearGradient(
//            gradient: Gradient(colors: [Color(hex: "#2A57F7"), Color(hex: "#A3B7FF"), Color(hex: "#2A57F7")]),
//            startPoint: UnitPoint(x: max(min(0 - (motionManager.roll / 1), 1), 0), y: 0),
//            endPoint: UnitPoint(x: max(min(0.5 + (motionManager.roll / 1), 10), 0), y: 0)
//        )
//    }
//    
//    
//    
//    
//    var body: some View {
//        GeometryReader { geometry in
//            
//            
//            ZStack(alignment: .center) {
//                colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
//                
//                //                VStack {
//                
//                ZStack {
//                    Image("pattern")
//                        .frame(width: 300, height: 300)
//                        .rotationEffect(Angle(radians: -motionManager.roll / 5))
//                    
//                    Image("highlight")
//                    //                        .frame(width: 300, height: 300)
//                        .position(highlightPosition)
//                        .colorMultiply(.white)
//                        .blendMode(.overlay)
//                    //                        .opacity(0.8)
//                        .blur(radius: (60))
//                    
//                    VStack {
//                        HStack(alignment: .center) {
//                            VStack(alignment: .leading) {
//                                
//                                Text("Ulrik Stoch Jensen")
//                                //                                .font(.title)
//                                    .fontWeight(.semibold)
//                                    .foregroundStyle(dynamicGradient)
//                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
//                                Text("United Kingdom")
//                                    .fontWeight(.regular)
//                                    .foregroundColor(Color(red: 0.57, green: 0.57, blue: 0.57))
//                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
//                                
//                                
//                            }
//                            
//                            
//                            Spacer()
//                            Image("badge")
//                        }
//                        
//                        
//                        ZStack {
//                            Image("center_circle")
//                                .resizable()
//                                .scaledToFit()
//                                .onTapGesture {
//                                    confettiCounter += 1
//                                    let generator = UIImpactFeedbackGenerator(style: .soft)
//                                    generator.impactOccurred()
//                                }
//                            
//                            CircularTextView(text: "Official CPH BikePass ·  DK4204245 · ")
//                                .font(.system(size: 10))
//                                .textCase(.uppercase)
//                                .foregroundColor(Color(red: 0.11, green: 0.21, blue: 0.53).opacity(0.57))
//                                .shadow(color: .white.opacity(0.20), radius: 0, x: 0, y: 1)
//                            
//                        }
//                        
//                        
//                        Spacer()
//                        HStack() {
//                            VStack(alignment: .leading) {
//                                
//                                Text("CPH BikePass")
//                                    .font(.title)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black)
//                                    .multilineTextAlignment(.leading)
//                                //                                .lineLimit(2)
//                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
//                                Text("Valid from July 1st 2024")
//                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
//                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
//                            }
//                            Spacer()
//                        }
//                    }
//                }
//                
//                .padding([.leading, .bottom, .trailing], 24.0)
//                .padding(.top, 17.0)
//                
//                .foregroundColor(.clear)
//                .frame(height: 400)
//                
//                .background(
//                    LinearGradient(
//                        stops: [
//                            Gradient.Stop(color: Color(red: 0.9, green: 0.9, blue: 0.9), location: 0.00),
//                            Gradient.Stop(color: Color(red: 0.78, green: 0.8, blue: 0.82), location: 1.00),
//                        ],
//                        startPoint: UnitPoint(x: 0.5, y: 0),
//                        endPoint: UnitPoint(x: 0.5, y: 1)
//                    )
//                )
//                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
//                //                .offset(y: verticalOffset)
//                //                .scaleEffect(scale)     // Apply scaling
//                //                .opacity(opacity)       // Apply opacity
//                .onAppear {
//                    if isFirstTime {
//                        
//                        do {
//                            self.hapticEngine = try CHHapticEngine()
//                            try self.hapticEngine?.start()
//                        } catch {
//                            print("Error starting the haptic engine: \(error)")
//                        }
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                            
//                            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
//                            var events = [CHHapticEvent]()
//                            
//                            for i in stride(from: 0, to: 0.8, by: 0.02) {
//                                // Gradually increase the intensity for each event
//                                let intensityValue = Float(i) / 0.5 // Scale the intensity based on the loop variable
//                                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue)
//                                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//                                events.append(event)
//                            }
//                            
//                            do {
//                                let pattern = try CHHapticPattern(events: events, parameters: [])
//                                let player = try hapticEngine?.makePlayer(with: pattern)
//                                try player?.start(atTime: 0)
//                            } catch {
//                                print("Pattern Playback Error: \(error)")
//                            }
//                            
//                            
//                            
//                            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
//                                //                                scale = 1.0  // End scale
//                                /*                                opacity = 1.0*/  // End opacity
//                                //                                verticalOffset = 0 // Move to its original position
//                                rotationAngleX = 0 // End rotation X
//                                rotationAngleY = 0 // End rotation Y
//                            }
//                            
//                            UserDefaults.standard.set(true, forKey: "hasSeenConfetti")
//                            isFirstTime = false
//                        }
//                        
//                    }
//                    else {
//                        //                        scale = 1.0
//                        //                        opacity = 1.0
//                        //                        verticalOffset = 0 // Move to its original position
//                        rotationAngleX = 0 // End rotation X
//                        rotationAngleY = 0 // End rotation Y
//                    }
//                }
//                
//                .rotation3DEffect(Angle(degrees: rotationAngleX), axis: (x: 1, y: 0, z: 0))
//                .rotation3DEffect(Angle(degrees: rotationAngleY), axis: (x: 0, y: 1, z: 0))
//                .gesture(
//                    DragGesture(minimumDistance: 0)
//                    
//                        .onChanged { value in
//                            withAnimation {
//                                let cardSize = geometry.size
//                                let tapLocation = value.location
//                                
//                                // Calculate offsets from the center
//                                let offsetX = (tapLocation.x - cardSize.width / 2) / (cardSize.width / 2)
//                                let offsetY = (tapLocation.y - cardSize.height / 2.5) / (cardSize.height / 2.5)
//                                
//                                // Adjust the tilt based on the tap location
//                                // Sensitivity adjustments might be necessary
//                                self.rotationAngleX = Double(-offsetY * 6) // Tilt verticallya
//                                self.rotationAngleY = Double(offsetX * 6) // Tilt horizontally
//                                
//                                let contentCenter = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
//                                let diffX = contentCenter.x - value.location.x
//                                let diffY = contentCenter.y - value.location.y
//                                highlightPosition = CGPoint(x: contentCenter.x + diffX, y: contentCenter.y + diffY)
//                            }
//                            
//                        }
//                        .onEnded { _ in
//                            withAnimation {
//                                self.rotationAngleX = 0
//                                self.rotationAngleY = 0
//                                highlightPosition = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
//                            }
//                        }
//                )
//                .shadow(color: .black.opacity(0.17), radius: 1.20376, x: 0, y: 0.99621)
//                .shadow(color: .black.opacity(0.12), radius: 2.89279, x: 0, y: 2.39404)
//                .shadow(color: .black.opacity(0.1), radius: 5.44688, x: 0, y: 4.50776)
//                .shadow(color: .black.opacity(0.09), radius: 9.71629, x: 0, y: 8.04107)
//                .shadow(color: .black.opacity(0.07), radius: 18.17326, x: 0, y: 15.03994)
//                .shadow(color: .black.opacity(0.05), radius: 43.5, x: 0, y: 36)
//                //                .padding(.horizontal, 24)
//                
//                ConfettiCannon(counter: $confettiCounter,
//                               num: 50, confettiSize: 10,
//                               rainHeight: 400,
//                               openingAngle: Angle(degrees: 60),
//                               closingAngle: Angle(degrees: 120),
//                               radius: 400
//                )
//            }
//            
//            .onAppear {
//                // Correctly center the highlight image when the view appears
//                highlightPosition = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
//            }
//        }
//        
//    }
//}
//
////
////struct MiniBikePassView_Previews: PreviewProvider {
////    static var previews: some View {
////        let viewModel = QuizViewModel()
////        viewModel.userName = "Ulrik Stoch Jensen"
////        return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
////    }
////}
//
//
//
//
//
////struct MiniBikePassView: View {
////    @Environment(\.colorScheme) var colorScheme
////    @ObservedObject var motionManager = MotionManager()
////    @State private var dragState = CGSize.zero
////    @State private var isTouching: Bool = false // Tracks whether the user is currently touching the screen
////    @State private var rotationAngleX: Double = 0
////    @State private var rotationAngleY: Double = 0
////
////    var body: some View {
////        GeometryReader { geometry in
////            ZStack(alignment: .center) {
////
////                VStack {
////                    HStack(alignment: .center) {
////                        Text("DK31314")
////                            .fontWeight(.semibold)
////                            .foregroundColor(Color(red: 0.57, green: 0.57, blue: 0.57))
////                            .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
////                        Spacer()
////                        Image("badge")
////                    }
////
////                    Image("center_circle")
////                        .resizable()
////                        .scaledToFit()
////                    Spacer()
////                    HStack() {
////                        VStack(alignment: .leading) {
////                            Text("Valid from July 1st 2022")
////                                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
////                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
////                            Text("CPH BikePass")
////                                .font(.title)
////                                .fontWeight(.bold)
////                                .foregroundColor(.black)
////                                .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
////                        }
////                        Spacer()
////                    }
////
////                }
////                .padding([.leading, .bottom, .trailing], 24.0)
////                .padding(.top, 17.0)
////
////                .foregroundColor(.clear)
////                .frame(height: 420)
////                .background(
////                    LinearGradient(
////                        stops: [
////                            Gradient.Stop(color: Color(red: 0.9, green: 0.9, blue: 0.9), location: 0.00),
////                            Gradient.Stop(color: Color(red: 0.78, green: 0.8, blue: 0.82), location: 1.00),
////                        ],
////                        startPoint: UnitPoint(x: 0.5, y: 0),
////                        endPoint: UnitPoint(x: 0.5, y: 1)
////                    )
////                )
////                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
////                .rotation3DEffect(Angle(degrees: rotationAngleX), axis: (x: 1, y: 0, z: 0))
////                .rotation3DEffect(Angle(degrees: rotationAngleY), axis: (x: 0, y: 1, z: 0))
////                .gesture(
////                    DragGesture(minimumDistance: 0)
////
////                    .onChanged { value in
////                        withAnimation {
////                            let cardSize = geometry.size
////                            let tapLocation = value.location
////
////                            // Calculate offsets from the center
////                            let offsetX = (tapLocation.x - cardSize.width / 2) / (cardSize.width / 2)
////                            let offsetY = (tapLocation.y - cardSize.height / 2.5) / (cardSize.height / 2.5)
////
////                            // Adjust the tilt based on the tap location
////                            // Sensitivity adjustments might be necessary
////                            self.rotationAngleX = Double(-offsetY * 12) // Tilt vertically
////                            self.rotationAngleY = Double(offsetX * 12) // Tilt horizontally
////                        }
////
////                    }
////                    .onEnded { _ in
////                        withAnimation {
////                            self.rotationAngleX = 0
////                            self.rotationAngleY = 0
////                        }
////                    }
////                )
////                .shadow(color: .black.opacity(0.17), radius: 1.20376, x: 0, y: 0.99621)
////                .shadow(color: .black.opacity(0.12), radius: 2.89279, x: 0, y: 2.39404)
////                .shadow(color: .black.opacity(0.1), radius: 5.44688, x: 0, y: 4.50776)
////                .shadow(color: .black.opacity(0.09), radius: 9.71629, x: 0, y: 8.04107)
////                .shadow(color: .black.opacity(0.07), radius: 18.17326, x: 0, y: 15.03994)
////                .shadow(color: .black.opacity(0.05), radius: 43.5, x: 0, y: 36)
//////                .padding(.horizontal, 24)
////            }
////        }
////    }
////}
//
////
//#Preview {
//    MiniBikePassView()
//}
//
