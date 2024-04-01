//
//  ContentView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationStack {
            HomeView()
        }
        
        
        

    }
}

#Preview("English") {
    ContentView()
        .environment(\.locale, Locale(identifier: "EN"))
}


#Preview("Danish") {
    ContentView()
        .environment(\.locale, Locale(identifier: "de"))
}

