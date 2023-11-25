//
//  BikePassApp.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

@main
struct BikePassApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                QuizView(quiz: quiz) // You need to pass your questions here
                    .tabItem {
                        Image(systemName: "questionmark.circle")
                        Text("Quiz")
                    }

                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
    }
}
