//
//  LearnView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 11/03/2024.
//

import SwiftUI
import AVKit

struct LearnView: View {
    
    @State private var showVideoPlayer = false
    @State private var showButton = false
    @State private var navigateToQuizView = false
    @Environment(\.colorScheme) var colorScheme
//    @Binding var showQuizView: Bool
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video_thumb", withExtension: "mp4")!)
    
    var body: some View {

        NavigationStack {
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: 0) {
//                    ForEach(rules.indices, id: \.self) { index in
//                        VStack {
//                            Text(rules[index].emoji)
//                                .font(.largeTitle)
//                            Text(rules[index].title)
//                                .font(.title)
//                            Text(rules[index].description)
//                                .padding()
//                        }
//                        .frame(width: UIScreen.main.bounds.width, height: 600)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 30))
//                        .scrollTargetLayout()
//                    }
//                }
//
//            }
//            .scrollTargetBehavior(.viewAligned)
            
            
            ScrollView {
                
                
                
                VStack(spacing: 24) {
                    
                    
                    VStack {
                        TabView {
                            ForEach(rules.indices, id: \.self) { index in
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(rules[index].title)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.leading)
                                                .padding(.bottom, 4.0)
                                                .font(.system(size: 18))
                                            
                                            Text(rules[index].emoji)
                                                .padding(.bottom, 4.0)
                                                .font(.system(size: 32))
                                        }
//

                                        Text(rules[index].description)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .padding(.bottom)
                                            .font(.system(size: 32))
                                    }
                                }

                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .frame(height: 400)

                    
                    VStack(alignment: .leading) {
                        
//                        Text("Watch the video again")
//                            .fontWeight(.semibold)
//                        
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
                    }
                    .padding(.top, 20.0)
                    

                    
//                    VStack(alignment: .leading) {
//                        VStack(alignment: .center) {
//                            Text("🚴")
//                                .padding(.bottom, 4.0)
//                                .font(.system(size: 50))
//                            Text("Stay on the Right")
//                                .fontWeight(.bold)
//                                .multilineTextAlignment(.center)
//                                .padding(.bottom, 4.0)
//                            Text("Always cycle on the right-hand side of roads and bike paths to align with traffic flow and ensure safety.")
//                                .fontWeight(.regular)
//                                .multilineTextAlignment(.center)
//                                .padding(.bottom)
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                }
                .padding(.horizontal)
                
                
            }
            .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
            
            .navigationTitle("Safety Rules")

            
        }

        
        
    }
}

#Preview {
    LearnView()
}

struct CyclingRule {
    let emoji: String
    let title: String
    let description: String
}

let rules = [
    CyclingRule(emoji: "🚴", title: "Stay on the Right", description: "Ride on the right-hand side to match traffic direction and ensure safety."),
    CyclingRule(emoji: "🚷", title: "No Biking in Walk Zones", description: "Sidewalks and crosswalks are for pedestrians, so keep your bike off these areas."),
    CyclingRule(emoji: "🚦", title: "Follow Lights", description: "Obey red lights and follow the signals for cars if there's no bike light."),
    CyclingRule(emoji: "↩️", title: "Left Turn Steps", description: "To turn left, stop at the intersection's edge, then go when it's green."),
    CyclingRule(emoji: "🚌", title: "Wait for Buses", description: "Stop for boarding or alighting bus passengers before you proceed."),
    CyclingRule(emoji: "✋", title: "Keep in Control", description: "Ride with a hand on the handlebar and both feet on pedals for stability."),
    CyclingRule(emoji: "📵", title: "No Phones or Drunk Riding", description: "Avoid using your phone or biking under the influence to prevent accidents."),
    CyclingRule(emoji: "🚲", title: "Bike Lanes for Bikes", description: "Stick to bike lanes for cycling and step off to walk with your bike."),
    CyclingRule(emoji: "💡", title: "Light Up", description: "Use proper lighting on your bike during dark hours or low visibility."),
    CyclingRule(emoji: "👶", title: "Carry Safely", description: "Ensure safe and proper carriage of items or passengers on your bike."),
    CyclingRule(emoji: "🔁", title: "Pass Carefully", description: "Overtake or ride alongside others only with enough room and safely.")
]
