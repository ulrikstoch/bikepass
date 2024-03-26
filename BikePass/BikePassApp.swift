//
//  BikePassApp.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI
import TelemetryClient

@main
struct BikePassApp: App {
    @StateObject var viewModel = QuizViewModel()
    var body: some Scene {
        WindowGroup {
            if viewModel.quizCompleted {
                BikePassOwner()
            } else {
                ContentView()
            }
        }
    }
    
    init() {
        let configuration = TelemetryManagerConfiguration(
            appID: "04139749-2E64-43E8-869E-794EEB9F25F2")
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send("applicationDidFinishLaunching")
    }
    
    
}

