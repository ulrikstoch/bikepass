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
    @ObservedObject var viewModel: QuizViewModel = QuizViewModel()
    @State private var showVideoPlayer = false
    @State private var showButton = false
    @State private var navigateToQuizView = false
    @State private var showingQuizSheet = false
    @State private var showBikePassView = false
    @State private var contentOpacity: Double = 1.0
    //    @Binding var showQuizView: Bool
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video_thumb", withExtension: "mp4")!)
    @State private var scaleVideo: CGFloat = 1
    
    
    
    var body: some View {
        
        VStack {
            if viewModel.quizCompleted && showBikePassView {
                BikePassOwner()
                    .transition(.opacity) // Apply an opacity transition
                    .animation(.easeIn, value: showBikePassView) // Animate the transition
                    .ignoresSafeArea(.all)
                    .navigationBarHidden(true)
            }
            else {
                ScrollView {
                    ScrollViewReader { scrollView in
                        
                        VStack(alignment: .leading) {
                            
                            
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
                                        .scaleEffect(scaleVideo)
                                        .gesture(
                                            DragGesture(minimumDistance: 0)
                                                .onChanged({ _ in
                                                    withAnimation(.easeIn(duration: 0.3)) {
                                                        scaleVideo = 0.9 // Scale down when tap begins
                                                    }
                                                })
                                                .onEnded({ _ in
                                                    withAnimation(.bouncy(duration: 0.4)) {
                                                        showVideoPlayer = true
                                                        scaleVideo = 1.0 // Ensure it scales back to normal when the gesture ends
                                                        
                                                        let generator = UIImpactFeedbackGenerator(style: .soft)
                                                        generator.impactOccurred()
                                                    }
                                                })
                                        )
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 48, style: .continuous))
                                
                            })
                            .sheet(isPresented: $showVideoPlayer) {
                                VideoPlayerView(showButton: $showButton, isPresented: $showVideoPlayer)
                            }
                            Spacer()
                            Text(NSLocalizedString("bikepass_video_title", comment: ""))
                                .font(.system(size: 37))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 5.0)
                                .padding(.top, 16.0)
                            
                            Text(NSLocalizedString("bikepass_video_description", comment: ""))
                                .fontWeight(.regular)
                            
                                .foregroundColor(colorScheme == .dark ? Color(UIColor.secondaryLabel) : Color(UIColor.secondaryLabel))
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                                .lineSpacing(5)
                            
                            
                            if showButton {
                                PrimaryButton(action: {
                                    withAnimation(.bouncy) {
                                        // Trigger haptic feedback or any other actions
                                        let generator = UIImpactFeedbackGenerator(style: .soft)
                                        generator.impactOccurred()
                                        
                                        withAnimation {
                                            contentOpacity = 0.0
                                        }
                                        showingQuizSheet = true
                                    }
                                    
                                    withAnimation {
                                        scrollView.scrollTo("bottomButton", anchor: .bottom)
                                    }
                                }, label: NSLocalizedString("bikepass_video_button", comment: ""))
                                .id("bottomButton")
                            }
                        }
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .padding(.horizontal, 24.0)
                        .onChange(of: showButton) {
                            // Directly check the showButton state
                            if showButton {
                                withAnimation {
                                    scrollView.scrollTo("bottomButton", anchor: .bottom)
                                }
                            }
                        }
                        .animation(.bouncy(duration: 0.4, extraBounce: 0.3))
                        
                        
                        
                    }
                    
                }
                //                .padding(.bottom, 24.0)
                
                .opacity(contentOpacity)
                .sheet(isPresented: $showingQuizSheet) {
                    NavigationView {
                        QuizSheetView(quiz: quiz, viewModel: viewModel, dismissAction: {
                            showingQuizSheet = false
                        })
                    }
                    .interactiveDismissDisabled(true)
                }
            }
        }
        .onChange(of: showingQuizSheet) {
            if !showingQuizSheet { // Directly checking the state variable
                withAnimation {
                    contentOpacity = 1.0
                }
            }
        }
        
        .onChange(of: viewModel.quizCompleted) {
            if viewModel.quizCompleted {
                withAnimation {
                    showBikePassView = true
                }
            }
        }
        
        //        .padding(.top, 32)
        .toolbarRole(.editor)
        
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
        
    }
}

struct VideoPlayerView: View {
    @Binding var showButton: Bool
    var player: AVPlayer

    @Binding var isPresented: Bool

    init(showButton: Binding<Bool>, isPresented: Binding<Bool>) {
        self._showButton = showButton
        self._isPresented = isPresented

        // Define your video URLs here
        let videoURLs = [
            "en": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/fc9d1fe9a56600dc53aaf51c7b1e7493/manifest/video.m3u8",
            "fr": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/fafe209ddda407f17f523d9adaeabc1f/manifest/video.m3u8",
            "de": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/261e78cf0bc00b045684d5833e57326d/manifest/video.m3u8",
            "zh": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/6443e3ad98f857437830a71fa6ac3fcb/manifest/video.m3u8",
            "jp": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/6bc935c8826eac49fc88e28f59a7b012/manifest/video.m3u8",
            "es": "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/01c971a88fe118f39caf5e45ce000dfe/manifest/video.m3u8"
        ]

        // Get the user's current language code
        let locale = Locale.current
        let languageCode = locale.languageCode ?? "en"  // Default to English

        // Select the appropriate URL
        let urlString = videoURLs[languageCode] ?? videoURLs["en"]!
        let url = URL(string: urlString)!

        // Initialize the player
        self.player = AVPlayer(url: url)
    }

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.play()
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                    self.isPresented = false // Dismiss the view when the video ends
                }
            }
            .onDisappear {
                player.pause()
                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
                showButton = true
            }
            .edgesIgnoringSafeArea(.all)
    }
}


//struct VideoPlayerView: View {
//    @Binding var showButton: Bool
//    let player = AVPlayer(url: Bundle.main.url(forResource: "full_video", withExtension: "mp4")!)
//    
//    @Binding var isPresented: Bool
//    
//    var body: some View {
//        VideoPlayer(player: player)
//            .onAppear {
//                player.play()
//                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
//                                    self.isPresented = false // Dismiss the view when video ends
//                                }
//            }
//            .onDisappear {
//                player.pause()
//                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//                showButton = true
//            }
//            .edgesIgnoringSafeArea(.all)
//    }
//}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
            .environment(\.locale, Locale(identifier: "EN"))
    }
}
