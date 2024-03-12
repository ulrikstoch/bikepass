//
//  BikePassApp.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

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
        
//        WindowGroup {
//           
//                ContentView()
//            
//        }
    }
}

