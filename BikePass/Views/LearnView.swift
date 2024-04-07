//
//  LearnView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 11/03/2024.
//

import SwiftUI
import AVKit
import VTabView

struct LearnView: View {
    
    @State private var showVideoPlayer = false
    @State private var showButton = false
    @State private var navigateToQuizView = false
    @Environment(\.colorScheme) var colorScheme
    @State var selectedTabIndex: Int = 0
    
    //    @Binding var showQuizView: Bool
    private let thumbnailPlayer = AVPlayer(url: Bundle.main.url(forResource: "video_thumb", withExtension: "mp4")!)
    
    var body: some View {
        //
        //        NavigationStack {
        
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                colorScheme == .dark ? Color(UIColor.systemBackground)
                    .ignoresSafeArea(): Color(UIColor.secondarySystemBackground).ignoresSafeArea()
                
                Image("blur_bg_light")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(colorScheme == .dark ? 0.17 : 0.2)
                
                VTabView(selection: $selectedTabIndex, indexPosition: .trailing) {
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            
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
                                        .overlay(
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .background(
                                                    LinearGradient(
                                                        stops: [
                                                            Gradient.Stop(color: .black.opacity(0), location: 0.0),
                                                            Gradient.Stop(color: .black.opacity(0.3), location: 1.0),
                                                        ],
                                                        startPoint: UnitPoint(x: 0.5, y: 0),
                                                        endPoint: UnitPoint(x: 0.5, y: 1)
                                                    )
                                                ),
                                            alignment: .bottomTrailing
                                        )
                                    
                                    Image(systemName: "play.circle.fill")
                                        .padding([.bottom, .trailing])
                                        .font(.system(size: 68))
                                        .foregroundColor(Color.white)
                                    
                                }
                                
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            })
                            .padding(.top, 16)
                            .padding(.bottom, 40)
                            .sheet(isPresented: $showVideoPlayer) {
                                VideoPlayerView(showButton: $showButton, isPresented: $showVideoPlayer)
                            }
                            
                            Text("Safety rules")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 6.0)
                            
                            Text("Refresh the safety rules by watching this video or keep scrolling ↓")
                                .font(.system(size: 28))
                                .multilineTextAlignment(.leading)
                                .frame(width: geometry.size.width * 0.9, alignment: .leading)
                            Spacer()
                            
                        }
                    }
                    
                    .padding(.horizontal, 24.0)
                    .tag(0)
                    
                    ForEach(rules.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            VStack(alignment: .leading, spacing: 0) {
                                Image(rules[index].imageName)
                                    .resizable()
                                    .aspectRatio(1/1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .padding(.bottom, 40)
                                    .padding(.top, 16)
                                    .padding(.horizontal, 24.0)
                                
                                Text(rules[index].title)
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 6.0)
                                    .padding(.leading, 24.0)
                                Text(rules[index].description)
                                    .font(.system(size: 28))
                                    .multilineTextAlignment(.leading)
                                    .frame(width: geometry.size.width * 0.8, alignment: .leading)
                                    .padding(.leading, 24.0)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        }
                        .tag(index + 1)
                        
                        
                    }
                    
                }

                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                
                CustomPageControl(numberOfPages: rules.count + 1, currentPage: $selectedTabIndex)
                    .frame(width: 0, height: 0)  // Adjust width and height as needed
                    .rotationEffect(.degrees(90))  // Rotate 90 degrees
                    .offset(x: -28, y: -90)
                
            }

            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            
            
            
        }
        .navigationTitle("Safety rules")

        
    }
}

#Preview {
    LearnView()
        .environment(\.locale, Locale(identifier: "de"))
}

struct CustomPageControl: UIViewRepresentable {
    
    let numberOfPages: Int
    @Binding var currentPage: Int
    @Environment(\.colorScheme) var colorScheme

    
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.numberOfPages = numberOfPages
        view.backgroundStyle = .prominent

        view.currentPageIndicatorTintColor = colorScheme == .dark ? .white : .systemBlue
        view.addTarget(context.coordinator, action: #selector(Coordinator.pageChanged), for: .valueChanged)
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = numberOfPages
        uiView.currentPage = currentPage
        uiView.currentPageIndicatorTintColor = colorScheme == .dark ? .white : .systemBlue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: CustomPageControl
        
        init(_ parent: CustomPageControl) {
            self.parent = parent
        }
        
        @objc func pageChanged(sender: UIPageControl) {
            parent.currentPage = sender.currentPage
        }
    }
}

struct CyclingRule {
    let title: String
    let description: String
    let imageName: String
}

let rules = [
    CyclingRule(title: NSLocalizedString("rule1_title", comment: ""),
                description: NSLocalizedString("rule1_description", comment: ""),
                imageName: "img_r1"),
    CyclingRule(title: NSLocalizedString("rule2_title", comment: ""),
                description: NSLocalizedString("rule2_description", comment: ""),
                imageName: "img_r2"),
    CyclingRule(title: NSLocalizedString("rule3_title", comment: ""),
                description: NSLocalizedString("rule3_description", comment: ""),
                imageName: "img_r3"),
    CyclingRule(title: NSLocalizedString("rule4_title", comment: ""),
                description: NSLocalizedString("rule4_description", comment: ""),
                imageName: "img_r4"),
    CyclingRule(title: NSLocalizedString("rule5_title", comment: ""),
                description: NSLocalizedString("rule5_description", comment: ""),
                imageName: "img_r5"),
    CyclingRule(title: NSLocalizedString("rule6_title", comment: ""),
                description: NSLocalizedString("rule6_description", comment: ""),
                imageName: "img_r6"),
    CyclingRule(title: NSLocalizedString("rule7_title", comment: ""),
                description: NSLocalizedString("rule7_description", comment: ""),
                imageName: "img_r7"),
    CyclingRule(title: NSLocalizedString("rule8_title", comment: ""),
                description: NSLocalizedString("rule8_description", comment: ""),
                imageName: "img_r8")
]

