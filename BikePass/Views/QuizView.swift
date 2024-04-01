//
//  QuizView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI

let quiz = Quiz(questions: [
    Question(
            question: NSLocalizedString("q1", comment: ""),
            options: [
                NSLocalizedString("q1_option1", comment: ""),
                NSLocalizedString("q1_option2", comment: ""),
                NSLocalizedString("q1_option3", comment: ""),
                NSLocalizedString("q1_option4", comment: "")
            ],
            correctAnswers: [1, 2],
            selectionType: .multiple,
            imageName: "img_q1",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/5c34a4d6ff917aa2a99d037e5ba182cc/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q2", comment: ""),
            options: [
                NSLocalizedString("q2_option1", comment: ""),
                NSLocalizedString("q2_option2", comment: ""),
                NSLocalizedString("q2_option3", comment: "")
            ],
            correctAnswers: [1],
            selectionType: .single,
            imageName: "img_q2",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/9ac931bbb709a55bd2640776cb243973/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q3", comment: ""),
            options: [
                NSLocalizedString("q3_option1", comment: ""),
                NSLocalizedString("q3_option2", comment: ""),
                NSLocalizedString("q3_option3", comment: "")
            ],
            correctAnswers: [1],
            selectionType: .single,
            imageName: "img_q3",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/89a9f12fc68925bec975c797af70ee57/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q4", comment: ""),
            options: [
                NSLocalizedString("q4_option1", comment: ""),
                NSLocalizedString("q4_option2", comment: ""),
                NSLocalizedString("q4_option3", comment: "")
            ],
            correctAnswers: [2],
            selectionType: .single,
            imageName: "img_q4",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/30f949f07b84480e39f275479cd8a2d6/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q5", comment: ""),
            options: [
                NSLocalizedString("q5_option1", comment: ""),
                NSLocalizedString("q5_option2", comment: ""),
                NSLocalizedString("q5_option3", comment: ""),
                NSLocalizedString("q5_option4", comment: "")
            ],
            correctAnswers: [0],
            selectionType: .single,
            imageName: "img_q5",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/69d5027bc2d290566ffc52fb089cd25e/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q6", comment: ""),
            options: [
                NSLocalizedString("q6_option1", comment: ""),
                NSLocalizedString("q6_option2", comment: ""),
                NSLocalizedString("q6_option3", comment: ""),
                NSLocalizedString("q6_option4", comment: "")
            ],
            correctAnswers: [2],
            selectionType: .single,
            imageName: "img_q6",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/1537a589b73f68659c0036520a2a4226/manifest/video.m3u8")!
        ),
        Question(
            question: NSLocalizedString("q7", comment: ""),
            options: [
                NSLocalizedString("q7_option1", comment: ""),
                NSLocalizedString("q7_option2", comment: ""),
                NSLocalizedString("q7_option3", comment: "")
            ],
            correctAnswers: [0],
            selectionType: .single,
            imageName: "img_q7",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/d6ef24e8df072060d89f3e2677f4a252/manifest/video.m3u8")!
        ),
    Question(
        question: NSLocalizedString("q8", comment: ""),
        options: [
            NSLocalizedString("q8_option1", comment: ""),
            NSLocalizedString("q8_option2", comment: ""),
            NSLocalizedString("q8_option3", comment: "")
        ],
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
    @State private var navigateToVideoView = false
    @State private var showingQuizSheet = false
    @State private var showBikePassView = false
    @State private var showVideoPlayer = false
    @State private var showButton = false
//    @State private var contentOpacity: Double = 1.0
    
    
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
//                        Image(colorScheme == .dark ? "pass_front_dark" : "pass_front")
                        Image("pass_front")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.leading, .bottom, .trailing], 8.0)
                            .shadow(color: .black.opacity(0.08), radius: 1.42548, x: 0, y: 2.30138)
                            .shadow(color: .black.opacity(0.06), radius: 3.60515, x: 0, y: 5.82036)
                            .shadow(color: .black.opacity(0.04), radius: 7.35416, x: 0, y: 11.87298)
                            .shadow(color: .black.opacity(0.04), radius: 15.14818, x: 0, y: 24.4561)
                            .shadow(color: .black.opacity(0.02), radius: 41.5, x: 0, y: 67)
                    }


                    NavigationLink(destination: VideoView(), isActive: $navigateToVideoView) {
                        EmptyView()
                    }

                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("bikepass_intro_title", comment: ""))
                            .font(.system(size: 37))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 5.0)
                            .padding(.top, 20.0)
                        
                        

                        
                        Text(NSLocalizedString("bikepass_intro_description", comment: ""))
                            .fontWeight(.regular)
                        
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.secondaryLabel) : Color(UIColor.secondaryLabel))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                            .lineSpacing(5)
                        
                    }
                    
                    
                    Spacer()
                    
                    VStack {
                        PrimaryButton(action: {
                            navigateToVideoView = true
                            
                            let generator = UIImpactFeedbackGenerator(style: .soft)
                            generator.impactOccurred()
                        }, label: NSLocalizedString("bikepass_intro_button", comment: ""))
                    }
                    
                    
                }
                .padding([.leading, .bottom, .trailing], 24.0)
                
                .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
            }
        }

        
    }
}



struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quiz: quiz)
            .environment(\.locale, Locale(identifier: "jp"))
    }
}
