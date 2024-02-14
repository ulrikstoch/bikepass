//
//  ContentView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            QuizView(quiz: quiz) // You need to pass your questions here
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Quiz")
                }

            BikePassView()
                .tabItem {
                    Image(systemName: "menucard.fill")
                    Text("Pass")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
