//
//  SettingsView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General")) {
                    NavigationLink(destination: Text("Content of Setting 1")) {
                        Text("Setting 1")
                    }
                    NavigationLink(destination: Text("Content of Setting 2")) {
                        Text("Setting 2")
                    }
                }
                Section(header: Text("Account")) {
                    NavigationLink(destination: Text("Content of Account Setting 1")) {
                        Text("Account Setting 1")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
