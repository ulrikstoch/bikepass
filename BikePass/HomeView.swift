//
//  HomeView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI
import AVKit

struct HomeView: View {
    var body: some View {
        VStack {
            Image("headerImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity, height: 400)
                .clipped()

            Button(action: {
                // Action to show the video
            }) {
                HStack {
                    Image(systemName: "video.fill")
                        .font(.largeTitle)
                    Text("Tap to Play")
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
