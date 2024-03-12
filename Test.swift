//
//  Test.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 10/03/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct SimpleConfettiView: View {
    @State private var counter = 0

    var body: some View {
        VStack {
            Button("Trigger Confetti") {
                counter += 1
            }
            ConfettiCannon(counter: $counter)
        }
    }
}

struct SimpleConfettiView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleConfettiView()
    }
}

