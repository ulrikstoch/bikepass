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
    @State private var navigateToQuizView = false
//    @Binding var showQuizView: Bool
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video_thumb", withExtension: "mp4")!)
    
    
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                
                VStack(alignment: .leading) {
                    
                    
                    
                    NavigationLink(destination: QuizView(quiz: quiz), isActive: $navigateToQuizView) {
                        EmptyView()
                    }
                    
                    
                    
                    Button(action: {
                        
                        showVideoPlayer = true
                        
                    }, label: {
                        ZStack(alignment: .bottomTrailing) {
                            
                            
                            
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
                            
                                .aspectRatio(500/690, contentMode: .fit)
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                            Gradient.Stop(color: .black.opacity(0.3), location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0.5, y: 0),
                                        endPoint: UnitPoint(x: 0.5, y: 1)
                                    ))
                            //                                    .background(.black.opacity(0.3))
                            
                            Image(systemName: "play.circle.fill")
                                .padding([.bottom, .trailing])
                                .font(.system(size: 68))
                                .foregroundColor(Color.white)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    })
                    .sheet(isPresented: $showVideoPlayer) {
                        VideoPlayerView(showButton: $showButton)
                    }
                    Spacer()
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
                            withAnimation(.bouncy) {
                                // Trigger haptic feedback or any other actions
                                let generator = UIImpactFeedbackGenerator(style: .soft)
                                generator.impactOccurred()
                                
                                // Trigger navigation
                                navigateToQuizView = true
                            }
                            
                            withAnimation {
                                scrollView.scrollTo("bottomButton", anchor: .bottom)
                            }
                        }, label: "Continue")
                        .id("bottomButton")
                    }
                }
                .padding(.horizontal, 24.0)
                .onChange(of: showButton) { _ in
                    // Optionally trigger the scroll when showButton becomes true
                    if showButton {
                        withAnimation {
                            scrollView.scrollTo("bottomButton", anchor: .bottom)
                        }
                    }
                }
                .animation(.bouncy(duration: 0.4, extraBounce: 0.3))
            }

        }
        .toolbarRole(.editor)
        

        

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
        VideoView()
    }
}
