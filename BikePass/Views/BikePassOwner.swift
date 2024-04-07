//
//  BikePassOwner.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 10/03/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct BikePassOwner: View {
    @ObservedObject var viewModel: QuizViewModel = QuizViewModel()
    @State private var scale: CGFloat = 0.25  // Initial scale
    @State private var opacity: Double = 0    // Initial opacity
    @State private var isFirstTime = !UserDefaults.standard.bool(forKey: "hasSeenConfetti")
    @State private var confettiCounter = 0
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        TabView {
            ZStack {
                BikePassView(viewModel: viewModel, bikePassID: viewModel.bikePassID, issueDate: viewModel.bikePassIssueDate)
                ConfettiCannon(counter: $confettiCounter,
                               num: 100, confettiSize: 10,
                               rainHeight: 800,
                               openingAngle: Angle(degrees: 60),
                               closingAngle: Angle(degrees: 120),
                               radius: 500
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .onAppear {
                if isFirstTime {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        UserDefaults.standard.set(true, forKey: "hasSeenConfetti")
                        isFirstTime = false
                        confettiCounter += 1  // Trigger confetti
                        print("Confetti counter updated to: \(confettiCounter)")
                    }
                    
                    
                }
            }
            .tabItem {
                
//                Image("bikepassIcon")
                Image(systemName: "wallet.pass.fill")
//                        .foregroundStyle(Color.purple)
                
                Text("BikePass")
                //                Label("BikePass", systemImage: "bikepassIcon")
            }
            
            LearnView()
                .tabItem {
                    
                    Image(systemName: "book.pages.fill")
                        .symbolRenderingMode(.hierarchical)
//                        .foregroundStyle(Color.purple)
                    
                    Text("Safety Rules")
//                    Label("Safety Rules", systemImage: "book.pages.fill")
//                        .symbolRenderingMode(.hierarchical)
                }
            SettingsView(viewModel: viewModel)
                .tabItem {
                    
//                    if selectedTab == 0 {
//                        Image("settingsIcon")
//                    } else {
//                        Image("settingsIcon")
//                    }
//                    Text("Settings")
                    
                    Label("Settings", systemImage: "gearshape")
                }
        }
        
        .navigationBarHidden(true)
        
    }
}

#Preview {
    
    BikePassOwner()
    
        .environment(\.locale, Locale(identifier: "DA"))
}
