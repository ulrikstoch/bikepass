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
                Section(header: Text("BikePass")) {
                    
                    Button("Clear UserDefaults") {
                        clearUserDefaults()
                    }

                    
                    NavigationLink(destination: Text("Content of Setting 1")) {
                        Text("Name")
                    }
                    NavigationLink(destination: Text("Content of Setting 2")) {
                        Text("Setting 2")
                    }
                }
                Section(header: Text("Account")) {
                    NavigationLink(destination: InfoView()) {
                        Text("About")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings", displayMode: .inline)
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
        SettingsView()
    }
}
