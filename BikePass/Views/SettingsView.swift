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
    @State private var showingCountrySelector = false
    @State private var showingQuizSheet = false
    
    @AppStorage("selectedLanguage") private var selectedLanguage = "Default" // Storing the user's language preference
    
    private let languageOptions = ["Default", "English", "Danish"]
    
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
                
                Image(colorScheme == .dark ? "blur_bg_light" : "blur_bg_light")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(colorScheme == .dark ? 0.17 : 0.2)
                
                
                ScrollView {
                    VStack(spacing: 32) {
                        
                        //                        VStack(alignment: .leading, spacing: 8) {
                        //                            Text("Name on BikePass")
                        //                                .foregroundColor(Color.gray)
                        //                                .kerning(1.2)
                        //                                .textCase(.uppercase)
                        //                                .font(.system(size: 14))
                        //                            TextField("Please enter your full name", text: $viewModel.userName)
                        //                                .textContentType(.name)
                        //                                .padding()
                        //                                .foregroundColor(Color(UIColor.label))
                        //
                        //                                .background(
                        //                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        //                                        .fill(
                        //                                            dynamicGradient
                        //                                                .shadow(.inner(color: .black.opacity(0.10), radius: 2, x: 0, y: 1))
                        //                                        )
                        //                                )
                        //                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        //                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.15) : Color.white.opacity(0.45), radius: 0, x: 0, y: 1)
                        //
                        //                                .overlay(
                        //                                    RoundedRectangle(cornerRadius: 15)
                        //                                        .stroke(isTextFieldFocused ? Color.blue : Color.clear, lineWidth: 2)  // Change the color and line width as needed
                        //                                )
                        //                                .overlay(
                        //                                    HStack {
                        //                                        Spacer()
                        //                                        if !viewModel.userName.isEmpty {
                        //                                            Button(action: {
                        //                                                viewModel.userName = ""
                        //                                            }) {
                        //                                                Image(systemName: "multiply.circle.fill")
                        //                                                    .foregroundColor(.gray)
                        //                                                    .padding()
                        //                                            }
                        //                                        }
                        //                                    }
                        //                                )
                        //
                        //                        }
                        
                        
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            //                            Text("Other")
                            //                                .foregroundColor(Color.gray)
                            //                                .kerning(1.2)
                            //                                .textCase(.uppercase)
                            //                                .font(.system(size: 14))
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
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) :  Color(red: 0, green: 0.48, blue: 1).opacity(0.14) , radius: 1.80332, x: 0, y: 2.06094)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 0, green: 0.48, blue: 1).opacity(0.1), radius: 4.56073, x: 0, y: 5.21226)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.05) : Color(red: 0, green: 0.48, blue: 1).opacity(0.08), radius: 9.30346, x: 0, y: 10.63252)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.03) : Color(red: 0, green: 0.48, blue: 1).opacity(0.06), radius: 19.16336, x: 0, y: 21.90099)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.02) : Color(red: 0, green: 0.48, blue: 1).opacity(0.04), radius: 52.5, x: 0, y: 60)
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
                                    Button {
                                        showingQuizSheet = true
                                        
                                    } label: {
                                        HStack(spacing: 14) {
                                            ZStack{
                                                Image("quiz")
                                            }
                                            .frame(width: 28.0, height: 28.0)
                                            .background(Color.green)
                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.17), radius: 1.37396, x: 0, y: 2.19833)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.12), radius: 3.47484, x: 0, y: 5.55974)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.05) : Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.09), radius: 7.08835, x: 0, y: 11.34136)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.03) : Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.08), radius: 14.60066, x: 0, y: 23.36105)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.02) : Color(red: 0.2, green: 0.78, blue: 0.35).opacity(0.05), radius: 40, x: 0, y: 64)
                                            Text("Try the quiz again")
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
                                    Button {
                                        ReviewHandler.requestReviewManually()
                                        
                                    } label: {
                                        HStack(spacing: 14) {
                                            ZStack{
                                                Image("star")
                                            }
                                            .frame(width: 28.0, height: 28.0)
                                            .background(Color.orange)
                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 1, green: 0.58, blue: 0).opacity(0.13), radius: 1.1069, x: 0, y: 2.76726)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 1, green: 0.58, blue: 0).opacity(0.09), radius: 2.66004, x: 0, y: 6.6501)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.05) : Color(red: 1, green: 0.58, blue: 0).opacity(0.08), radius: 5.00862, x: 0, y: 12.52155)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.03) : Color(red: 1, green: 0.58, blue: 0).opacity(0.06), radius: 8.93452, x: 0, y: 22.33631)
                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.02) : Color(red: 1, green: 0.58, blue: 0).opacity(0.05), radius: 16.71104, x: 0, y: 41.77761)
//                                            .shadow(color: colorScheme == .dark ? .black.opacity(0.01) : Color(red: 1, green: 0.58, blue: 0).opacity(0.04), radius: 40, x: 0, y: 100)
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
                                        ShareLink(item: URL(string: "https://apps.apple.com/app/id6480235027")!) {
                                            HStack(spacing: 14) {
                                                Image("share")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 28.0, height: 28.0)
                                                    .background(Color.purple)
                                                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                                                    .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 0.69, green: 0.32, blue: 0.87).opacity(0.25), radius: 1.37396, x: 0, y: 1.13351)
                                                    .shadow(color: colorScheme == .dark ? .black.opacity(0.1) : Color(red: 0.69, green: 0.32, blue: 0.87).opacity(0.17), radius: 3.47484, x: 0, y: 2.86674)
                                                    .shadow(color: colorScheme == .dark ? .black.opacity(0.05) : Color(red: 0.69, green: 0.32, blue: 0.87).opacity(0.14), radius: 7.08835, x: 0, y: 5.84789)
                                                    .shadow(color: colorScheme == .dark ? .black.opacity(0.03) : Color(red: 0.69, green: 0.32, blue: 0.87).opacity(0.11), radius: 14.60066, x: 0, y: 12.04554)
                                                    .shadow(color: colorScheme == .dark ? .black.opacity(0.02) : Color(red: 0.69, green: 0.32, blue: 0.87).opacity(0.08), radius: 40, x: 0, y: 33)
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
                            .sheet(isPresented: $showingQuizSheet) {
                                NavigationView {
                                    QuizSheetView(quiz: quiz, viewModel: viewModel, dismissAction: {
                                        showingQuizSheet = false
                                    })
                                }
                                .interactiveDismissDisabled(true)
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity)
                            .background(colorScheme == .dark ? Color(red: 0.19, green: 0.23, blue: 0.29).opacity(0.5) : Color(UIColor.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            
                            .shadow(
                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.00) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.04),
                                radius: 0.68698, x: 0, y: 0.92742
                            )
                            .shadow(
                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.0) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.03),
                                radius: 1.73742, x: 0, y: 2.34552
                            )
                            .shadow(
                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.0) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.02),
                                radius: 3.54417, x: 0, y: 4.78464
                            )
                            .shadow(
                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.0) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.02),
                                radius: 7.30033, x: 0, y: 9.85544
                            )
                            .shadow(
                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.0) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.01),
                                radius: 20, x: 0, y: 27
                            )
                        }
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Developer")
//                                .foregroundColor(Color.gray)
//                                .kerning(1.2)
//                                .textCase(.uppercase)
//                                .font(.system(size: 14))
//                            VStack(alignment: .leading, spacing: 0) {
//                                
//                                VStack(alignment: .leading) {
//                                    Button {
//                                        if let url = URL(string: UIApplication.openSettingsURLString) {
//                                            UIApplication.shared.open(url)
//                                        }
//                                        
//                                    } label: {
//                                        HStack(spacing: 14) {
//                                            ZStack{
//                                                Image("globe")
//                                            }
//                                            .frame(width: 28.0, height: 28.0)
//                                            .background(Color.green)
//                                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
//                                            Text("Language")
//                                                .foregroundStyle(Color(UIColor.label))
//                                            Spacer()
//                                            Image(systemName: "chevron.right")
//                                        }
//                                        .padding(.trailing, 8)
//                                    }
//                                }
//                                .padding([.top, .bottom, .trailing], 20.0)
//                                
//                                
//                                
//                            }
//                            .padding(.leading, 20)
//                            .frame(maxWidth: .infinity)
//                            .background(colorScheme == .dark ? Color(red: 0.19, green: 0.23, blue: 0.29).opacity(0.5) : Color(UIColor.systemBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                            
//                            .shadow(
//                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.04) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.03),
//                                radius: 0.68698, x: 0, y: 0.92742
//                            )
//                            .shadow(
//                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.03) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.02),
//                                radius: 1.73742, x: 0, y: 2.34552
//                            )
//                            .shadow(
//                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.02) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.01),
//                                radius: 3.54417, x: 0, y: 4.78464
//                            )
//                            .shadow(
//                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.01) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.01),
//                                radius: 7.30033, x: 0, y: 9.85544
//                            )
//                            .shadow(
//                                color: colorScheme == .dark ? Color(red: 0.2, green: 0.2, blue: 0.25).opacity(0.01) : Color(red: 0.01, green: 0.2, blue: 0.44).opacity(0.005),
//                                radius: 20, x: 0, y: 27
//                            )
//                        }
//                        
//                        
//                        Button("Clear UserDefaults") {
//                            clearUserDefaults()
//                        }
//                        .buttonStyle(.borderedProminent)
                        
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
