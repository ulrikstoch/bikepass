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
                    UserDefaults.standard.set(true, forKey: "hasSeenConfetti")

                        isFirstTime = false
                        confettiCounter += 1  // Trigger confetti
                        print("Confetti counter updated to: \(confettiCounter)")
                    
                }


            }

            

                        .tabItem {

                            Label("BikePass", systemImage: "wallet.pass.fill")
                        }
            
                    LearnView()
                        .tabItem {

                            Label("Safety Rules", systemImage: "book.pages.fill")
                        }
                    SettingsView()
                        .tabItem {

                            Label("Settings", systemImage: "gearshape")
                        }
                }


        .navigationBarHidden(true)

    }
}

#Preview {
    BikePassOwner()
}
