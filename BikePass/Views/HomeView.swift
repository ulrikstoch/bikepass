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
    @State private var navigateToQuizView = false
    @State private var showingInfoView = false
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mp4")!)

    var body: some View {
        NavigationStack {
            
            ZStack {
                
                colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
//                Image(colorScheme == .dark ? "blur_bg_light" : "blur_bg_light")
//                    .resizable()
//                    .edgesIgnoringSafeArea(.all)
//                    .opacity(colorScheme == .dark ? 0.17 : 0.2)
                
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
                        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                    
                    
                    Text(NSLocalizedString("welcome_message", comment: ""))
                        .font(.system(size: 37))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5.0)
                        .padding(.top, 16.0)
                    
                    
                    Text(NSLocalizedString("welcome_description", comment: ""))

                        .fontWeight(.regular)
                    
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.secondaryLabel) : Color(UIColor.secondaryLabel))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(5)
                    
                    Spacer()
                    
                    
                    
                    ZStack {
                        
                        
                        NavigationLink(destination: QuizView(quiz: quiz), isActive: $navigateToQuizView) {
                            EmptyView()
                        }
                        
                        
                        PrimaryButton(action: {
                            // Trigger haptic feedback or any other actions
                            let generator = UIImpactFeedbackGenerator(style: .soft)
                            generator.impactOccurred()
                            
                            // Trigger navigation
                            navigateToQuizView = true
                        }, label: NSLocalizedString("welcome_button", comment: ""))
                        
                    }
                }
                .padding([.leading, .bottom, .trailing], 24.0)

            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("‎‎")

            
        }
    }
}

#Preview("English") {
    HomeView()
        .environment(\.locale, Locale(identifier: "en-US"))
}

#Preview {
    HomeView()
        .environment(\.locale, Locale(identifier: "DA"))
}
