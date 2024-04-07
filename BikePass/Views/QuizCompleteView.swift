//
//  QuizCompleteView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 06/02/2024.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            withAnimation {
                keyboardHeight = keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        withAnimation {
            keyboardHeight = 0
        }
    }
}


struct QuizCompleteView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var showingCountrySelector = false
    
    @State private var imageScale: CGFloat = 0.2 // Start with a scaled-down image
    @State private var textOpacity: Double = 0 // Start with invisible text and button
    @State private var fieldOpacity: Double = 0 // Start with invisible text and button
    @State private var buttonOpacity: Double = 0 // Start with invisible text and button
    @ObservedObject var viewModel: QuizViewModel
    @ObservedObject var keyboardResponder = KeyboardResponder()
    
    @State
    private var scrollViewContentSize: CGSize = .zero
    
    
    //    var viewModel: QuizViewModel
    var dismissAction: () -> Void
    
    var recommendedCountry: String? {
        let locale = Locale.current
        guard let countryCode = locale.regionCode,
              let countryName = locale.localizedString(forRegionCode: countryCode) else {
            return nil
        }
        return "\(flag(country: countryCode))"
    }
    
    func flag(country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
    
    
    var body: some View {
        
        let lightModeGradient = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.88, green: 0.88, blue: 0.9), location: 0.00),
                Gradient.Stop(color: Color(red: 0.95, green: 0.95, blue: 0.96), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        
        let darkModeGradient = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.05, green: 0.07, blue: 0.08), location: 0.00),
                Gradient.Stop(color: Color(red: 0.08, green: 0.11, blue: 0.11), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
        )
        
        // Define dynamicGradient based on the current color scheme
        let dynamicGradient = colorScheme == .dark ? darkModeGradient : lightModeGradient
        
        
        VStack {
            Spacer()
            VStack {
//                Image(colorScheme == .dark ? "complete_dark" : "complete_light")
                Image("complete")
                    .scaleEffect(imageScale)
                    .onAppear {
                        withAnimation(.bouncy(duration: 0.4)) {
                            imageScale = 1 // Scale to normal size
                        }
                        withAnimation(.easeIn(duration: 1).delay(0.4)) {
                            textOpacity = 1 // Fade in text and button after the image scales
                        }
                        withAnimation(.easeIn(duration: 1).delay(0.6)) {
                            fieldOpacity = 1 // Fade in text and button after the image scales
                        }
                        withAnimation(.easeIn(duration: 1).delay(1)) {
                            buttonOpacity = 1 // Fade in text and button after the image scales
                        }
                    }
                    .padding(.bottom, 16)
                
                VStack(spacing: 12) {
                    Text("You've passed!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .opacity(textOpacity)
                    
                    Text("We look forward to seeing you on the bike lanes of Copenhagen.")
                        .multilineTextAlignment(.center)
                        .opacity(keyboardResponder.keyboardHeight > 0 ? 0.0 : 1)
                        .animation(keyboardResponder.keyboardHeight > 0 ? .easeIn(duration: 0.01) : .easeIn(duration: 0.2).delay(0.25), value: keyboardResponder.keyboardHeight > 0)
                        .opacity(textOpacity)
                }
            }
            
            
            //
            
            
            
            Spacer()
            
            
            
            
            HStack {
                
                
                
                TextField("Please enter your full name", text: $viewModel.userName)
                    .textContentType(.name)
                    .padding()
                    .foregroundColor(Color(UIColor.label))
                
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(
                                dynamicGradient
                                    .shadow(.inner(color: .black.opacity(0.10), radius: 2, x: 0, y: 1))
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.07) : Color.white.opacity(0.45), radius: 0, x: 0, y: 1)
                    .opacity(fieldOpacity)
                
                    .overlay(
                        HStack {
                            Spacer()
                            if !viewModel.userName.isEmpty {
                                Button(action: {
                                    viewModel.userName = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            }
                        }
                            .opacity(fieldOpacity)
                    )
                
                if let recommended = recommendedCountry {
                    Button(action: {
                        showingCountrySelector = true
                    }) {
                        Text(viewModel.countryEmoji)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(
                                        dynamicGradient
                                            .shadow(.inner(color: .black.opacity(0.10), radius: 2, x: 0, y: 1))
                                    )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.07) : Color.white.opacity(0.45), radius: 0, x: 0, y: 1)
                            .opacity(fieldOpacity)
                    }
                    .sheet(isPresented: $showingCountrySelector) {
                        CountrySelectorView(selectedCountry: $viewModel.userCountry)
                            .presentationDetents([.medium, .large])
                    }
                    
                }
                
            }
            .padding(.bottom, 10)
            
            
            
            Button(action: {
                if !viewModel.userName.isEmpty {
                        viewModel.quizCompleted = true
                        dismissAction()
                    }
            }, label: {
                
                ZStack {
                    
                    Rectangle()
                    
                        .foregroundColor(.clear)
                        .frame(height: 52)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: .white.opacity(0.2), location: 0.00),
                                    Gradient.Stop(color: .white.opacity(0), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15) // 2
                                .stroke(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98).opacity(0), location: 0.50),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                ), lineWidth: 3)
                        )
                        .background(Color(red: 0.17, green: 0.34, blue: 0.97))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)
                    
                    
                    
                    
                    
                    Text("Show BikePass")
                        .font(.headline)
                        .foregroundColor(viewModel.userName.isEmpty ? Color.white.opacity(0.2) : Color.white)
                    
                    
                }
                .disabled(viewModel.userName.isEmpty)
                .opacity(buttonOpacity)
            })
            //            .padding(.horizontal, 5)
            .padding(.bottom, 24.0)
            
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
    }
}

struct QuizCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of QuizViewModel
        let viewModel = QuizViewModel()
        
        // Pass the viewModel to QuizCompleteView
        QuizCompleteView(viewModel: viewModel, dismissAction: {
            print("Dismiss action triggered")
        })
        .environment(\.locale, Locale(identifier: "DA"))
    }
}

