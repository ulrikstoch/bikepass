//
//  SettingsView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: QuizViewModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isTextFieldFocused: Bool
    
    @AppStorage("selectedLanguage") private var selectedLanguage = "Default" // Storing the user's language preference
    
    private let languageOptions = ["Default", "English", "Danish"]
    
    let link = URL(string: "https://www.hackingwithswift.com")!
    
    let indices = Array(0..<8)
    
    
    var body: some View {
        
        
        let lightModeGradient = LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.88, green: 0.88, blue: 0.92), location: 0.00),
                Gradient.Stop(color: Color(red: 0.93, green: 0.93, blue: 0.96), location: 1.00),
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
        
        NavigationView {
            ZStack {
                
                colorScheme == .dark ? Color(UIColor.systemBackground)
                    .ignoresSafeArea(): Color(UIColor.secondarySystemBackground).ignoresSafeArea()
                
                
                ScrollView {
                    VStack(spacing: 32) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name on BikePass")
                                .foregroundColor(Color.gray)
                                .kerning(1.2)
                                .textCase(.uppercase)
                                .font(.system(size: 14))
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
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.15) : Color.white.opacity(0.45), radius: 0, x: 0, y: 1)
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(isTextFieldFocused ? Color.blue : Color.clear, lineWidth: 2)  // Change the color and line width as needed
                                )
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
                                )
                            
                        }
                        
                        
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Other")
                                .foregroundColor(Color.gray)
                                .kerning(1.2)
                                .textCase(.uppercase)
                                .font(.system(size: 14))
                            VStack(alignment: .leading, spacing: 0) {
                                VStack(alignment: .leading) {
                                    NavigationLink {
                                        InfoView()
                                        
                                    } label: {
                                        HStack(spacing: 14) {
                                            ZStack{
                                                Image("about")
                                            }
                                            .frame(width: 28.0, height: 28.0)
                                            .background(Color.blue)
                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                            Text("About BikePass")
                                                .foregroundColor(Color(UIColor.label))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .padding(.trailing, 8)
                                        
                                    }
                                }
                                .padding([.top, .bottom, .trailing], 20.0)
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    NavigationLink {
                                        InfoView()
                                        
                                    } label: {
                                        HStack(spacing: 14) {
                                            ZStack{
                                                Image("star")
                                            }
                                            .frame(width: 28.0, height: 28.0)
                                            .background(Color.orange)
                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                            Text("Rate on App Store")
                                                .foregroundStyle(Color(UIColor.label))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .padding(.trailing, 8)
                                    }
                                }
                                .padding([.top, .bottom, .trailing], 20.0)
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    
                                    HStack(spacing: 14) {
                                        ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!) {
                                            HStack(spacing: 14) {
                                                Image("share")
                                                    .resizable() // Ensure your image can resize
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 28.0, height: 28.0)
                                                    .background(Color.green)
                                                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                Text("Share with friends")
                                                    .foregroundStyle(Color(UIColor.label))
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                            }
                                            
                                            .padding(.trailing, 8)
                                        }
                                    }
                                }
                                .padding([.top, .bottom, .trailing], 20.0)
                                
                                
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity)
                            .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .black.opacity(0.04), radius: 0.68698, x: 0, y: 0.92742)
                            .shadow(color: .black.opacity(0.03), radius: 1.73742, x: 0, y: 2.34552)
                            .shadow(color: .black.opacity(0.02), radius: 3.54417, x: 0, y: 4.78464)
                            .shadow(color: .black.opacity(0.02), radius: 7.30033, x: 0, y: 9.85544)
                            .shadow(color: .black.opacity(0.01), radius: 20, x: 0, y: 27)
                        }
                        
                        
                        Button("Clear UserDefaults") {
                            clearUserDefaults()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .navigationTitle("Settings")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
            }
        }
    }
}

func clearUserDefaults() {
    if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = QuizViewModel()
        
        SettingsView(viewModel: viewModel)
    }
}
