//
//  HomeView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var navigateToVideoView = false
    
//    @Binding var showVideoView: Bool
//    @Binding var showQuizView: Bool
//    @Binding var fadeTransition: Bool
    
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Image("header")
                    .resizable()
                
                    .scaledToFit()
                    .cornerRadius(30)
                
                Text("Welcome to \nCopenhagen 👋")
                    .font(.system(size: 37))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5.0)
                    .padding(.top, 16.0)
                
                Text("Before you begin your two-wheeled journey, we’d like to make sure you know how rules of biking in Copenhagen, to ensure you and other cyclists safety.")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                
                    .foregroundColor(colorScheme == .dark ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                
                Spacer()
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 62)
                        .background(
                            colorScheme == .dark ? darkModeGradient : lightModeGradient
                        )
                    
                        .cornerRadius(20)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.95), radius: 0, x: 0, y: 1)
                    
                    NavigationLink(destination: VideoView(), isActive: $navigateToVideoView) {
                        EmptyView()
                    }
                    
//                    .hidden()
                    
                    PrimaryButton(action: {
                        // Trigger haptic feedback or any other actions
                        let generator = UIImpactFeedbackGenerator(style: .soft)
                        generator.impactOccurred()
                        
                        // Trigger navigation
                        navigateToVideoView = true
                    }, label: "Continue")
                    
//                    PrimaryButton(action: {
//                            showVideoView = true
//                            // Optionally trigger haptic feedback or any other actions
//                            let generator = UIImpactFeedbackGenerator(style: .soft)
//                            generator.impactOccurred()
//                        
//                    }, label: "Continue")
                    
                }
            }
                    .padding(.all, 24.0)

        }

        
        
        
        
        
//        .padding(.all, 24.0)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
