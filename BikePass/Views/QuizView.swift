//
//  QuizView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

let quiz = Quiz(questions: [
    Question(
        question: "Where can you bike in Copenhagen?",
        options: ["Everywhere", "On the bike lanes", "Right side of the road", "Left side of the road"],
        correctAnswers: [1, 2],
        selectionType: .multiple,
        imageName: "img_q1",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/5c34a4d6ff917aa2a99d037e5ba182cc/manifest/video.m3u8")!
        
    ),
    Question(
        question: "How do you ride if you’re more than one person?",
        options: ["Side-by-side", "In a line behind each other", "Doesn’t matter"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q2",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/9ac931bbb709a55bd2640776cb243973/manifest/video.m3u8")!
    ),
    Question(
        question: "Which side do you overtake on?",
        options: ["Right side", "Left side", "Both"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q3",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/89a9f12fc68925bec975c797af70ee57/manifest/video.m3u8")!
    ),
    Question(
        question: "What do you do before overtaking?",
        options: ["Nothing", "Yell at the person in front to make sure they know you’re overtaking", "Look behind you to make sure there’s not other cyclists about to overtake you"],
        correctAnswers: [2],
        selectionType: .single,
        imageName: "img_q4",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/30f949f07b84480e39f275479cd8a2d6/manifest/video.m3u8")!
    ),
    Question(
        question: "What do you do when you hear a bell behind you?",
        options: ["Pull to the right and let the person overtake", "Slow down and wait for the person to overtake", "Ignore it", "Ring my bell"],
        correctAnswers: [0],
        selectionType: .single,
        imageName: "img_q5",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/69d5027bc2d290566ffc52fb089cd25e/manifest/video.m3u8")!
    ),
    Question(
        question: "You want to stop in bike lane or road – what do you do?",
        options: ["Just stop", "Raise one of your hands and stop", "Raise your left hand and pull to the right", "Raise your right hand and pull to the right"],
        correctAnswers: [2],
        selectionType: .single,
        imageName: "img_q6",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/1537a589b73f68659c0036520a2a4226/manifest/video.m3u8")!
    ),
    Question(
        question: "How do you turn to the right?",
        options: ["Indicate with your right arm and then turn right", "Just turn to the right", "Indicate with your left arm and then turn right"],
        correctAnswers: [0],
        selectionType: .single,
        imageName: "img_q7",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/d6ef24e8df072060d89f3e2677f4a252/manifest/video.m3u8")!
    ),
    Question(
        question: "How do you make a left turn?",
        options: ["Make a direct left turn", "Cross the street, stop and wait for green again.", "Use the pedetrian crosswalk"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q8",
        videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/f2550c0d2a5a90c42bcffa26a7039f67/manifest/video.m3u8")!
    ),
    
])


// Gradient for Light Mode
//let lightModeGradient = LinearGradient(
//    stops: [
//        Gradient.Stop(color: Color(red: 0.87, green: 0.88, blue: 0.89), location: 0.00),
//        Gradient.Stop(color: Color(red: 0.92, green: 0.93, blue: 0.93), location: 1.00),
//    ],
//    startPoint: .top,
//    endPoint: .bottom
//)
//
//// Gradient for Dark Mode
//let darkModeGradient = LinearGradient(
//    stops: [
//        Gradient.Stop(color: Color(red: 0.13, green: 0.14, blue: 0.15), location: 0.00),
//        Gradient.Stop(color: Color(red: 0.13, green: 0.19, blue: 0.2), location: 1.00),
//    ],
//    startPoint: UnitPoint(x: 0.5, y: 0),
//    endPoint: UnitPoint(x: 0.5, y: 1)
//)


struct QuizView: View {
    let quiz: Quiz
    @ObservedObject var viewModel: QuizViewModel = QuizViewModel()
    @State private var showingQuizSheet = false
    @State private var showBikePassView = false
    @State private var showVideoPlayer = false
    @State private var showButton = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
                    if viewModel.quizCompleted && showBikePassView {
                        BikePassOwner()
                            .transition(.opacity) // Apply an opacity transition
                            .animation(.easeIn, value: showBikePassView) // Animate the transition
                            .ignoresSafeArea(.all)
                            .navigationBarHidden(true)

                    } else {
                        VStack(alignment: .center) {
                            
                            VStack {
                                Image("package")
//                                MiniBikePassView()
                            }
                            .frame(maxHeight: 400)
//                            .padding(.horizontal)
//                            .padding(.bottom)
                            


                            VStack(alignment: .leading) {
                                Text("Unlock your own Bike Pass today")
                                    .font(.system(size: 32))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 5.0)
                                    .padding(.top, 16.0)
                                
                                
                                Text("Complete the 8 question test and get your own BikePass today.")
                                    .font(.system(size: 17))
                                    .fontWeight(.regular)
                                
                                    .foregroundColor(colorScheme == .dark ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(5)

                            }

                        Spacer()
                            
                            VStack {
                                PrimaryButton(action: {
                                            showingQuizSheet = true
                                            let generator = UIImpactFeedbackGenerator(style: .soft)
                                            generator.impactOccurred()
                                }, label: "Start test")
                            }
                            
                            
                        }
                        .toolbarRole(.editor)
                        .padding([.top, .leading, .trailing], 24.0)
                        
                        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
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
                .onChange(of: viewModel.quizCompleted) { completed in
                    if completed {
                        withAnimation {
                            showBikePassView = true
                        }
                    }
                }


    }
}



struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quiz: quiz)
    }
}
