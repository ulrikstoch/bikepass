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
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mp4")!)
    
//    @Binding var showVideoView: Bool
//    @Binding var showQuizView: Bool
//    @Binding var fadeTransition: Bool
    
    
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                VideoPlayer(player: thumbnailPlayer)
                    .onAppear {
                        let audioSession = AVAudioSession.sharedInstance()
                        try? audioSession.setCategory(.ambient)
                        try? audioSession.setActive(true)

                        thumbnailPlayer.play()
                        NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: thumbnailPlayer.currentItem,
                            queue: .main) { _ in
                                // Seek to the start
                                thumbnailPlayer.seek(to: CMTime.zero)
                                // Play the video again
                                thumbnailPlayer.play()
                            }
                    }
                
                
                    .aspectRatio(1/1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
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
                    
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.95), radius: 0, x: 0, y: 1)
                    
                    NavigationLink(destination: VideoView(), isActive: $navigateToVideoView) {
                        EmptyView()
                    }
                    
                    
                    PrimaryButton(action: {
                        // Trigger haptic feedback or any other actions
                        let generator = UIImpactFeedbackGenerator(style: .soft)
                        generator.impactOccurred()
                        
                        // Trigger navigation
                        navigateToVideoView = true
                    }, label: "Continue")
        
                }
                NavigationLink(destination: InfoView()) {
                                    Text("About BikePass")
                                        .foregroundColor(Color.gray)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 32)
                                }
                                .buttonStyle(.plain)
            }
                    .padding(.all, 24.0)
//                    .toolbar {
//
//                        ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
//                            HStack(spacing: 3) {
//                                NavigationLink {
//                                    InfoView()
//                                } label: {
//                                    Image(systemName: "info.circle.fill")
//                                        .font(.system(size: 22))
//            //                            .symbolRenderingMode(.hierarchical)
//                                        .foregroundStyle(Color.gray)
//                                }
//                            }
//
//                        }
//
//                    }

        }
        

        
        
        
        
        
//        .padding(.all, 24.0)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
