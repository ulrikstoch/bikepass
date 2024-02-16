//
//  ContentView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

struct ContentView: View {
//    @State private var showVideoView = false
//    @State private var showQuizView = false
//    @State private var fadeTransition = false
    
    
    var body: some View {
        
        NavigationStack {
            HomeView()
        }
        
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//ZStack {
//    HomeView(showVideoView: $showVideoView, fadeTransition: $fadeTransition)
//    
//    if showVideoView {
//        VideoView(showQuizView: $showQuizView)
//    }
//    
//    if showQuizView {
//        QuizView(quiz: quiz)
//    }
//}



//        TabView {
//            HomeView()
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//
//            QuizView(quiz: quiz) // You need to pass your questions here
//                .tabItem {
//                    Image(systemName: "checklist")
//                    Text("Quiz")
//                }
//
//            BikePassView()
//                .tabItem {
//                    Image(systemName: "menucard.fill")
//                    Text("Pass")
//                }
//        }
