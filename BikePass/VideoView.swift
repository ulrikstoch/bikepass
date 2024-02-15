//
//  VideoView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 14/02/2024.
//

import SwiftUI
import AVKit


struct VideoView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showVideoPlayer = false
    @State private var showButton = false
    @Binding var showQuizView: Bool


    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            Text("Prepare for the BikePass Test")
                .font(.system(size: 37))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 5.0)
                .padding(.top, 16.0)
            
            Text("Before you can get your BikePass, we recommend watching a short video to learn the bike rules in Copenhagen.")
                .font(.system(size: 17))
                .fontWeight(.regular)
            
                .foregroundColor(colorScheme == .dark ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                .multilineTextAlignment(.leading)
                .padding(.bottom)
                .lineSpacing(5)
            
            if showButton {
                PrimaryButton(action: {
                    showQuizView = true
                        // Optionally trigger haptic feedback or any other actions
                        let generator = UIImpactFeedbackGenerator(style: .soft)
                        generator.impactOccurred()
                }, label: "Continue")
            }
            
            Button(action: {showVideoPlayer = true}, label: {
                ZStack(alignment: .bottomTrailing) {
                    Image("video_thumb")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(30)
                    
                    Image(systemName: "play.circle.fill")
                        .padding([.bottom, .trailing])
                        .font(.system(size: 68))
                        .foregroundColor(Color.white)
                    
                    
                }
            })
            .sheet(isPresented: $showVideoPlayer) {
                VideoPlayerView(showButton: $showButton)
            }
            Spacer()
            
            
            
        }
        .padding(.all, 24.0)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
    }
}

struct VideoPlayerView: View {
    @Binding var showButton: Bool
    let player = AVPlayer(url: Bundle.main.url(forResource: "full_video", withExtension: "mp4")!)
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
                showButton = true
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(showQuizView: .constant(false))
    }
}
