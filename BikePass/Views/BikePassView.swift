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

struct BadgeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.41959*width, y: 0.04595*height))
        path.addCurve(to: CGPoint(x: 0.58042*width, y: 0.04595*height), control1: CGPoint(x: 0.46271*width, y: -0.00253*height), control2: CGPoint(x: 0.5373*width, y: -0.00253*height))
        path.addLine(to: CGPoint(x: 0.60285*width, y: 0.07116*height))
        path.addCurve(to: CGPoint(x: 0.69786*width, y: 0.10651*height), control1: CGPoint(x: 0.62691*width, y: 0.0982*height), control2: CGPoint(x: 0.66243*width, y: 0.11142*height))
        path.addLine(to: CGPoint(x: 0.7309*width, y: 0.10194*height))
        path.addCurve(to: CGPoint(x: 0.85411*width, y: 0.20761*height), control1: CGPoint(x: 0.79442*width, y: 0.09314*height), control2: CGPoint(x: 0.85155*width, y: 0.14214*height))
        path.addLine(to: CGPoint(x: 0.85543*width, y: 0.24167*height))
        path.addCurve(to: CGPoint(x: 0.90599*width, y: 0.33118*height), control1: CGPoint(x: 0.85686*width, y: 0.27819*height), control2: CGPoint(x: 0.87576*width, y: 0.31166*height))
        path.addLine(to: CGPoint(x: 0.93418*width, y: 0.34938*height))
        path.addCurve(to: CGPoint(x: 0.96211*width, y: 0.51129*height), control1: CGPoint(x: 0.98837*width, y: 0.38438*height), control2: CGPoint(x: 1.00132*width, y: 0.45946*height))
        path.addLine(to: CGPoint(x: 0.94171*width, y: 0.53825*height))
        path.addCurve(to: CGPoint(x: 0.92415*width, y: 0.64004*height), control1: CGPoint(x: 0.91984*width, y: 0.56716*height), control2: CGPoint(x: 0.91327*width, y: 0.60522*height))
        path.addLine(to: CGPoint(x: 0.9343*width, y: 0.6725*height))
        path.addCurve(to: CGPoint(x: 0.85388*width, y: 0.81488*height), control1: CGPoint(x: 0.9538*width, y: 0.73492*height), control2: CGPoint(x: 0.91651*width, y: 0.80094*height))
        path.addLine(to: CGPoint(x: 0.8213*width, y: 0.82213*height))
        path.addCurve(to: CGPoint(x: 0.74385*width, y: 0.88857*height), control1: CGPoint(x: 0.78637*width, y: 0.82991*height), control2: CGPoint(x: 0.75741*width, y: 0.85475*height))
        path.addLine(to: CGPoint(x: 0.73121*width, y: 0.9201*height))
        path.addCurve(to: CGPoint(x: 0.58007*width, y: 0.97634*height), control1: CGPoint(x: 0.7069*width, y: 0.98073*height), control2: CGPoint(x: 0.63682*width, y: 1.00681*height))
        path.addLine(to: CGPoint(x: 0.55056*width, y: 0.96048*height))
        path.addCurve(to: CGPoint(x: 0.44945*width, y: 0.96048*height), control1: CGPoint(x: 0.51891*width, y: 0.94348*height), control2: CGPoint(x: 0.4811*width, y: 0.94348*height))
        path.addLine(to: CGPoint(x: 0.41993*width, y: 0.97634*height))
        path.addCurve(to: CGPoint(x: 0.2688*width, y: 0.9201*height), control1: CGPoint(x: 0.36319*width, y: 1.00681*height), control2: CGPoint(x: 0.29311*width, y: 0.98073*height))
        path.addLine(to: CGPoint(x: 0.25616*width, y: 0.88857*height))
        path.addCurve(to: CGPoint(x: 0.17871*width, y: 0.82213*height), control1: CGPoint(x: 0.2426*width, y: 0.85475*height), control2: CGPoint(x: 0.21364*width, y: 0.82991*height))
        path.addLine(to: CGPoint(x: 0.14613*width, y: 0.81488*height))
        path.addCurve(to: CGPoint(x: 0.06571*width, y: 0.6725*height), control1: CGPoint(x: 0.0835*width, y: 0.80094*height), control2: CGPoint(x: 0.04621*width, y: 0.73492*height))
        path.addLine(to: CGPoint(x: 0.07586*width, y: 0.64004*height))
        path.addCurve(to: CGPoint(x: 0.0583*width, y: 0.53825*height), control1: CGPoint(x: 0.08674*width, y: 0.60522*height), control2: CGPoint(x: 0.08017*width, y: 0.56716*height))
        path.addLine(to: CGPoint(x: 0.0379*width, y: 0.51129*height))
        path.addCurve(to: CGPoint(x: 0.06583*width, y: 0.34938*height), control1: CGPoint(x: -0.00131*width, y: 0.45946*height), control2: CGPoint(x: 0.01164*width, y: 0.38438*height))
        path.addLine(to: CGPoint(x: 0.09402*width, y: 0.33118*height))
        path.addCurve(to: CGPoint(x: 0.14457*width, y: 0.24167*height), control1: CGPoint(x: 0.12425*width, y: 0.31166*height), control2: CGPoint(x: 0.14315*width, y: 0.27819*height))
        path.addLine(to: CGPoint(x: 0.1459*width, y: 0.20761*height))
        path.addCurve(to: CGPoint(x: 0.26911*width, y: 0.10194*height), control1: CGPoint(x: 0.14846*width, y: 0.14214*height), control2: CGPoint(x: 0.20559*width, y: 0.09314*height))
        path.addLine(to: CGPoint(x: 0.30215*width, y: 0.10651*height))
        path.addCurve(to: CGPoint(x: 0.39716*width, y: 0.07116*height), control1: CGPoint(x: 0.33758*width, y: 0.11142*height), control2: CGPoint(x: 0.3731*width, y: 0.0982*height))
        path.addLine(to: CGPoint(x: 0.41959*width, y: 0.04595*height))
        path.closeSubpath()
        return path
    }
}


struct CircularTextView: View {
    let text: String
    @State private var rotationAngle: Double = 330
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<text.count, id: \.self) { index in
                    let character = Array(text)[index]
                    Text(String(character))
                        .position(x: geometry.size.width / 2, y: 67) // Adjust y to move the text up or down
                        .rotationEffect(.degrees(Double(index) * 360 / Double(text.count)), anchor: .center)
                }
            }
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                withAnimation(Animation.linear(duration: 120).repeatForever(autoreverses: false)) {
                    rotationAngle = -360
                }
            }
        }
    }
}



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




struct BikePassView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var motionManager = MotionManager()
    @State private var dragState = CGSize.zero
    @State private var isTouching: Bool = false // Tracks whether the user is currently touching the screen
    @State private var isFirstTime = !UserDefaults.standard.bool(forKey: "hasSeenConfetti")
    @State private var scale: CGFloat = 0.25  // Initial scale
    @State private var opacity: Double = 0    // Initial opacity
    @State private var verticalOffset: CGFloat = 600 // Start from off-screen below
    @State private var rotationAngleX: Double = -50 // Example starting angle
    @State private var rotationAngleY: Double = 0 // Example starting angle
    @State private var hapticEngine: CHHapticEngine?
    @State private var confettiCounter = 0
    @State private var highlightPosition = CGPoint.zero
    @State private var scaleCircle: CGFloat = 1.0
    @State private var isFlipped = false
    
    
    
    
    
    
    @ObservedObject var viewModel: QuizViewModel
    
    let bikePassID: String
    let issueDate: String
    
    
    
    private var dynamicGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color(hex: "#2A57F7"), Color(hex: "#A3B7FF"), Color(hex: "#2A57F7")]),
            startPoint: UnitPoint(x: max(min(0 - (motionManager.roll / 1), 1), 0), y: 0),
            endPoint: UnitPoint(x: max(min(0.5 + (motionManager.roll / 1), 10), 0), y: 0)
        )
    }
    
    
    
    
    var body: some View {
        GeometryReader { geometry in
            
            
            ZStack(alignment: .center) {
                
                colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
                Image(colorScheme == .dark ? "blur_bg_light" : "blur_bg_light")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(colorScheme == .dark ? 0.17 : 0.25)
                
                
                
                
                ZStack {
                    Image("pattern")
                        .frame(width: 300, height: 300)
                        .rotationEffect(Angle(degrees: motionManager.roll * 360 / 60))
                        .opacity(0.7)
                    
                    Image("highlight")
                    //                        .frame(width: 300, height: 300)
                        .position(highlightPosition)
                        .colorMultiply(.white)
                        .blendMode(.overlay)
                    //                        .opacity(0.8)
                        .blur(radius: (60))
                    
                    VStack {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                
                                Text(viewModel.userName)
                                //                                .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(dynamicGradient)
                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                                Text(viewModel.userCountryWithoutEmoji)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(red: 0.57, green: 0.57, blue: 0.57))
                                    .shadow(color: .white.opacity(0.50), radius: 0, x: 0, y: 1)
                                
                                
                            }
                            
                            
                            Spacer()
                            
                            ZStack {
                                BadgeShape()
                                    .fill(.white)
                                    .fill(
                                        AngularGradient(
                                            stops: [
                                                Gradient.Stop(color: Color(red: 0.87, green: 0.91, blue: 0.97).opacity(0.69), location: 0.12),
                                                Gradient.Stop(color: Color(red: 0.32, green: 0.59, blue: 1).opacity(0.53), location: 0.21),
                                                Gradient.Stop(color: Color(red: 0.85, green: 0.88, blue: 0.78), location: 0.32),
                                                Gradient.Stop(color: Color(red: 0.91, green: 0.92, blue: 0.91).opacity(0.66), location: 0.46),
                                                Gradient.Stop(color: Color(red: 0.3, green: 0.44, blue: 0.79).opacity(0.46), location: 0.68),
                                                Gradient.Stop(color: Color(red: 0.55, green: 0.74, blue: 0.02).opacity(0.14), location: 0.81),
                                                Gradient.Stop(color: Color(red: 0.69, green: 0.93, blue: 0.02).opacity(0.69), location: 0.87),
                                                Gradient.Stop(color: Color(red: 0.97, green: 0.99, blue: 0.9), location: 0.99),
                                            ],
                                            center: .center,
                                            angle: .degrees(motionManager.roll * 360 / 25)
                                        )
                                        
                                        .shadow(.inner(color: .black.opacity(0.25), radius: 1, x: 0, y: 1))
                                        
                                    )
                                    .shadow(color: .white.opacity(0.4), radius: 0, x: 0, y: 1)
                                    .frame(width: 48, height: 48)
                                
                                ZStack {
                                    Text("DK")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black.opacity(0.5))
                                        .blendMode(.overlay)
                                    Text("DK")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black.opacity(0.5))
                                        .blendMode(.overlay)
                                    Text("DK")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black.opacity(0.3))
                                        .blendMode(.overlay)
                                }
                                
                                
                            }
                            .frame(width: 48, height: 48)
                            //
                            //
                            //                            Image("badge")
                        }
                        
                        
                        ZStack {
                            
                            
                            Image("center_circle")
                                .resizable()
                                .scaledToFit()
                            
                            
                            Circle()
                                .frame(width: 230)
                                .foregroundStyle(.white)
                                .opacity(0.000001)
                                .onTapGesture {
                                    confettiCounter += 1
                                    let generator = UIImpactFeedbackGenerator(style: .soft)
                                    generator.impactOccurred()
                                }
                            
                            CircularTextView(text: "Official CPH BikePass ·  \(viewModel.bikePassID) · ")
                                .font(.system(size: 10))
                                .textCase(.uppercase)
                                .foregroundColor(Color(red: 0.11, green: 0.21, blue: 0.53).opacity(0.57))
                                .shadow(color: .white.opacity(0.20), radius: 0, x: 0, y: 1)
                            
                            
                        }
                        
                        
                        
                        
                        Spacer()
                        HStack() {
                            VStack(alignment: .leading) {
                                
                                Text("CPH BikePass")
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
                    
                }
                
                .padding([.leading, .bottom, .trailing], 24.0)
                .padding(.top, 17.0)
                
                .foregroundColor(.clear)
                .frame(height: 500)
                
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(hue: 0.625, saturation: 0.051, brightness: 0.964), location: 0.00),
                            Gradient.Stop(color: Color(hue: 0.643, saturation: 0.093, brightness: 0.92), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .offset(y: verticalOffset)
                //                .scaleEffect(scale)     // Apply scaling
                .opacity(opacity)       // Apply opacity
                .onAppear {
                    if isFirstTime {
                        
                        do {
                            self.hapticEngine = try CHHapticEngine()
                            try self.hapticEngine?.start()
                        } catch {
                            print("Error starting the haptic engine: \(error)")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
                            var events = [CHHapticEvent]()
                            
                            for i in stride(from: 0, to: 0.8, by: 0.02) {
                                // Gradually increase the intensity for each event
                                let intensityValue = Float(i) / 0.5 // Scale the intensity based on the loop variable
                                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensityValue)
                                let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
                                events.append(event)
                            }
                            
                            do {
                                let pattern = try CHHapticPattern(events: events, parameters: [])
                                let player = try hapticEngine?.makePlayer(with: pattern)
                                try player?.start(atTime: 0)
                            } catch {
                                print("Pattern Playback Error: \(error)")
                            }
                            
                            
                            
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                                //                                scale = 1.0  // End scale
                                opacity = 1.0  // End opacity
                                verticalOffset = 0 // Move to its original position
                                rotationAngleX = 0 // End rotation X
                                rotationAngleY = 0 // End rotation Y
                            }
                            
                            UserDefaults.standard.set(true, forKey: "hasSeenConfetti")
                            isFirstTime = false
                        }
                        
                    }
                    else {
                        scale = 1.0
                        opacity = 1.0
                        verticalOffset = 0 // Move to its original position
                        rotationAngleX = 0 // End rotation X
                        rotationAngleY = 0 // End rotation Y
                    }
                }
                
                .rotation3DEffect(Angle(degrees: rotationAngleX), axis: (x: 1, y: 0, z: 0))
                .rotation3DEffect(Angle(degrees: rotationAngleY), axis: (x: 0, y: 1, z: 0))
                //                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .gesture(
                    DragGesture(minimumDistance: 0)
                    
                        .onChanged { value in
                            withAnimation(.default) {
                                let cardSize = geometry.size
                                let tapLocation = value.location
                                
                                // Calculate offsets from the center
                                let offsetX = (tapLocation.x - cardSize.width / 2) / (cardSize.width / 2)
                                let offsetY = (tapLocation.y - cardSize.height / 2.5) / (cardSize.height / 2.5)
                                
                                //                                 Adjust the tilt based on the tap location
                                //                                 Sensitivity adjustments might be necessary
                                self.rotationAngleX = Double(-offsetY * 5) // Tilt verticallya
                                self.rotationAngleY = Double(offsetX * 5) // Tilt horizontally
                                
                                let positionAdjustmentX = -offsetX * 5 // Move horizontally
                                let positionAdjustmentY = -offsetY * 8 // Move vertically
                                
                                self.dragState = CGSize(width: positionAdjustmentX, height: positionAdjustmentY)
                                
                                let contentCenter = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
                                let diffX = contentCenter.x - value.location.x
                                let diffY = contentCenter.y - value.location.y
                                highlightPosition = CGPoint(x: contentCenter.x + diffX, y: contentCenter.y + diffY)
                                
                                //                                let dragThreshold: CGFloat = 100 // Adjust the threshold based on your preference
                                //                                    if abs(value.translation.width) > dragThreshold {
                                //                                        withAnimation {
                                //                                            isFlipped.toggle()
                                //                                            print("flipped")
                                //                                        }
                                //                                    }
                            }
                            
                        }
                        .onEnded { _ in
                            withAnimation(.easeOut) {
                                self.rotationAngleX = 0
                                self.rotationAngleY = 0
                                self.dragState = .zero
                                highlightPosition = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
                            }
                        }
                )
                
                //blue shadow
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 1.45281, x: 0, y: 2.0201)
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.09), radius: 3.4913, x: 0, y: 4.85457)
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.07), radius: 6.57381, x: 0, y: 9.14073)
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.06), radius: 11.72656, x: 0, y: 16.30551)
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.05), radius: 21.93324, x: 0, y: 30.49765)
                //                .shadow(color: Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.03), radius: 52.5, x: 0, y: 73)
                
                //black shadow w. blue
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.12) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 1.20376, x: 0, y: 0.99621)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.09) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.09), radius: 2.89279, x: 0, y: 2.39404)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.12) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 5.44688, x: 0, y: 4.50776)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.12) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 9.71629, x: 0, y: 8.04107)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.12) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 18.17326, x: 0, y: 15.03994)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.12) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.12), radius: 43.5, x: 0, y: 36)
                
                .offset(self.dragState)
                .padding(.horizontal, 24)
                
                ConfettiCannon(counter: $confettiCounter,
                               num: 50, confettiSize: 10,
                               rainHeight: 400,
                               openingAngle: Angle(degrees: 60),
                               closingAngle: Angle(degrees: 120),
                               radius: 400
                )
            }
            
            
            .onAppear {
                // Correctly center the highlight image when the view appears
                highlightPosition = CGPoint(x: geometry.size.width / 2.5, y: geometry.size.height / 3)
            }
        }
        
    }
}


#Preview("English") {
    let viewModel = QuizViewModel()
    viewModel.userName = "John Appleseed"
    viewModel.userCountry = "Test Test United Kingdom"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Danish") {
    let viewModel = QuizViewModel()
    viewModel.userName = "Mads Henriksen"
    viewModel.userCountry = "Test Test Danmark"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "da"))
}

#Preview("Spanish") {
    let viewModel = QuizViewModel()
    viewModel.userName = "Carlos Hernández"
    viewModel.userCountry = "Test Test España"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "es"))
}

#Preview("French") {
    let viewModel = QuizViewModel()
    viewModel.userName = "Émilie Dubois"
    viewModel.userCountry = "Test Test France"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "fr"))
}

#Preview("Chinese") {
    let viewModel = QuizViewModel()
    viewModel.userName = "Li Wei"
    viewModel.userCountry = "Test Test 中国"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "zh"))
}

#Preview("Japanese") {
    let viewModel = QuizViewModel()
    viewModel.userName = "Sato Ryo"
    viewModel.userCountry = "Test Test 日本"
    return BikePassView(viewModel: viewModel, bikePassID: "DK48275024", issueDate: "March 10, 2024")
        .environment(\.locale, Locale(identifier: "jp"))
}



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}


