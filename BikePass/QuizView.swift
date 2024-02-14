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
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
        
    ),
    Question(
        question: "How do you ride if you’re more than one person?",
        options: ["Side-by-side", "In a line behind each other", "Doesn’t matter"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q2",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "Which side do you overtake on?",
        options: ["Right side", "Left side", "Both"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q3",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "What do you do before overtaking?",
        options: ["Nothing", "Yell at the person in front to make sure they know you’re overtaking", "Look behind you to make sure there’s not other cyclists about to overtake you"],
        correctAnswers: [2],
        selectionType: .single,
        imageName: "img_q4",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "What do you do when you hear a bell behind you?",
        options: ["Pull to the right and let the person overtake", "Slow down and wait for the person to overtake", "Ignore it", "Ring my bell"],
        correctAnswers: [0],
        selectionType: .single,
        imageName: "img_q5",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "You want to stop in bike lane or road – what do you do?",
        options: ["Just stop", "Raise one of your hands and stop", "Raise your left hand and pull to the right", "Raise your right hand and pull to the right"],
        correctAnswers: [2],
        selectionType: .single,
        imageName: "img_q6",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "How do you turn to the right?",
        options: ["Indicate with your right arm and then turn right", "Just turn to the right", "Indicate with your left arm and then turn right"],
        correctAnswers: [0],
        selectionType: .single,
        imageName: "img_q7",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    Question(
        question: "How do you make a left turn?",
        options: ["Make a direct left turn", "Cross the street, stop and wait for green again.", "Use the pedetrian crosswalk"],
        correctAnswers: [1],
        selectionType: .single,
        imageName: "img_q8",
        videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
    ),
    
])


// Gradient for Light Mode
let lightModeGradient = LinearGradient(
    stops: [
        Gradient.Stop(color: Color(red: 0.87, green: 0.88, blue: 0.89), location: 0.00),
        Gradient.Stop(color: Color(red: 0.92, green: 0.93, blue: 0.93), location: 1.00),
    ],
    startPoint: .top,
    endPoint: .bottom
)

// Gradient for Dark Mode
let darkModeGradient = LinearGradient(
    stops: [
        Gradient.Stop(color: Color(red: 0.13, green: 0.14, blue: 0.15), location: 0.00),
        Gradient.Stop(color: Color(red: 0.13, green: 0.19, blue: 0.2), location: 1.00),
    ],
    startPoint: UnitPoint(x: 0.5, y: 0),
    endPoint: UnitPoint(x: 0.5, y: 1)
)


struct QuizView: View {
    let quiz: Quiz
    @State private var showingQuizSheet = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Image("header_2")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                
                Text("Get your BikePass")
                    .font(.system(size: 37))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5.0)
                    .padding(.top, 16.0)
                
                Text("BikePass is the easiest way to ensure your safety when biking. Follow the steps to get your own BikePass today")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                
                    .foregroundColor(colorScheme == .dark ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(5)
                
                Spacer()
                    .padding(16.0)
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
                            Image("img_q1")
                                .resizable()
                                .scaledToFit()
                            
                            HStack(alignment: .center, spacing: 8) {
                                Text("Step 1")
                                    .fontWeight(.semibold)
                                
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(.white.opacity(0.5))
                            .cornerRadius(48)
                            .padding()
                            Spacer()
                        }
                        

                        VStack(alignment: .leading) {
                            Text("Learn about bike rules in Copenhagen")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 30.0)
                                .lineSpacing(4)
                            
                            Text("1:45 min")
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 18.0)
                                .foregroundColor(Color(red: 0.17, green: 0.34, blue: 0.97))
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        
                        
                        
                    }
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(.black.opacity(0.08), lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topLeading) {
                            Image("img_q6")
                                .resizable()
                                .scaledToFit()
                            
                            HStack(alignment: .center, spacing: 8) {
                                Text("Step 2")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(.white.opacity(0.5))
                            .cornerRadius(48)
                            .padding()
                            Spacer()
                        }
                        

                        VStack(alignment: .leading) {
                            Text("Complete the Bike Pass Test")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, 30.0)
                                .lineSpacing(4)
                            
                            Text("2-3 min")
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 18.0)
                                .foregroundColor(Color(red: 0.17, green: 0.34, blue: 0.97))
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 62)
                                .background(
                                    colorScheme == .dark ? darkModeGradient : lightModeGradient
                                )
                            
                                .cornerRadius(20)
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.95), radius: 0, x: 0, y: 1)
                            
                            Button(action: {
                                showingQuizSheet = true
                                let generator = UIImpactFeedbackGenerator(style: .soft)
                                generator.impactOccurred()
                            }, label: {
                                
                                ZStack {
                                    
                                    Rectangle()
                                    
                                        .foregroundColor(.clear)
                                        .frame(height: 52)
                                        .background(
                                            LinearGradient(
                                                stops: [
                                                    Gradient.Stop(color: .white.opacity(0.2), location: 0.00),
                                                    Gradient.Stop(color: .white.opacity(0), location: 1.00),
                                                ],
                                                startPoint: UnitPoint(x: 0.5, y: 0),
                                                endPoint: UnitPoint(x: 0.5, y: 1)
                                            )
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15) // 2
                                                .stroke(LinearGradient(
                                                    stops: [
                                                        Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98), location: 0.00),
                                                        Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98).opacity(0), location: 0.50),
                                                    ],
                                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                                ), lineWidth: 3)
                                        )
                                        .background(Color(red: 0.17, green: 0.34, blue: 0.97))
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)
                                    
                                    
                                    
                                    
                                    
                                    Text("Start quiz")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    
                                }
                            })
                            .padding(.horizontal, 5)
                            
                        }
                        
                    }
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(.black.opacity(0.08), lineWidth: 1)
                    )
                }
                

                
                VStack {
                    
                    Button("Watch instructional video") {
                        showingQuizSheet = true
                    }
                    .buttonStyle(.borderless)
                    
                }
                
            }
//            .padding(.top, 64.0)
            .padding(.all, 24.0)
        }
        
//        .ignoresSafeArea(.all)
        .sheet(isPresented: $showingQuizSheet) {
            NavigationView {
                QuizSheetView(quiz: quiz, dismissAction: {
                    showingQuizSheet = false
                })
            }
            .interactiveDismissDisabled(true)
        }
        
        //        VStack {
        //            Spacer()
        //            Image("bikepass_quiz")
        //            Spacer()
        //            VStack(spacing: 8) {
        //                Text("Get your Bike Pass today")
        //                    .font(.title2)
        //                    .fontWeight(.bold)
        //                Text("Answer correctly on all 8 questions and you will unlock your Bike Pass for Copenhagen")
        //                    .font(.subheadline)
        //                    .multilineTextAlignment(.center)
        //            }
        //            .padding(.horizontal, 24.0)
        //
        //
        //            Spacer()
        //            VStack(spacing: 20) {
        //
        //                ZStack {
        //
        //                    Rectangle()
        //                      .foregroundColor(.clear)
        //                      .frame(height: 62)
        //                      .background(
        //                          colorScheme == .dark ? darkModeGradient : lightModeGradient
        //                      )
        //
        //                      .cornerRadius(20)
        //                      .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.95), radius: 0, x: 0, y: 1)
        //
        //                    Button(action: {
        //                        showingQuizSheet = true
        //                        let generator = UIImpactFeedbackGenerator(style: .soft)
        //                        generator.impactOccurred()
        //                    }, label: {
        //
        //                        ZStack {
        //
        //                            Rectangle()
        //
        //                              .foregroundColor(.clear)
        //                              .frame(height: 52)
        //                              .background(
        //                                LinearGradient(
        //                                  stops: [
        //                                    Gradient.Stop(color: .white.opacity(0.2), location: 0.00),
        //                                    Gradient.Stop(color: .white.opacity(0), location: 1.00),
        //                                  ],
        //                                  startPoint: UnitPoint(x: 0.5, y: 0),
        //                                  endPoint: UnitPoint(x: 0.5, y: 1)
        //                                )
        //                              )
        //                              .overlay(
        //                                  RoundedRectangle(cornerRadius: 15) // 2
        //                                  .stroke(LinearGradient(
        //                                    stops: [
        //                                    Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98), location: 0.00),
        //                                    Gradient.Stop(color: Color(red: 0.5, green: 0.6, blue: 0.98).opacity(0), location: 0.50),
        //                                    ],
        //                                    startPoint: UnitPoint(x: 0.5, y: 0),
        //                                    endPoint: UnitPoint(x: 0.5, y: 1)
        //                                    ), lineWidth: 3)
        //                              )
        //                              .background(Color(red: 0.17, green: 0.34, blue: 0.97))
        //                              .cornerRadius(15)
        //                              .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)
        //
        //
        //
        //
        //
        //                            Text("Start quiz")
        //                                .font(.headline)
        //                                .foregroundColor(.white)
        //
        //
        //                        }
        //                        })
        //                    .padding(.horizontal, 5)
        //
        //                }
        //
        //                Button("Watch instructional video") {
        //                    showingQuizSheet = true
        //                }
        //                .buttonStyle(.borderless)
        //            }
        //            .padding(.horizontal)
        //
        //            Spacer()
        //        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
        //
        //        .sheet(isPresented: $showingQuizSheet) {
        //            NavigationView {
        //                QuizSheetView(quiz: quiz, dismissAction: {
        //                    showingQuizSheet = false
        //                })
        //            }
        //            .interactiveDismissDisabled(true)
        //        }
        
    }
}



struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quiz: quiz)
    }
}
