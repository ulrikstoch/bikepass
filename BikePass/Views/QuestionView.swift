//
//  QuestionView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 05/02/2024.
//

import SwiftUI
import AVKit

struct QuestionView: View {
    var question: Question
    var totalQuestions: Int
    var questionIndex: Int
    var onCorrectAnswer: () -> Void // Closure to call when the answer is correct
    @State private var selectedAnswers = Set<Int>()
    @State private var showingAlert = false
    @State private var navigateToNextQuestion = false // State to trigger navigation
    
    @State private var buttonOffset: CGFloat = 100
    @State private var buttonOpacity: Double = 0
    
    @State private var alertOffset: CGFloat = -100 // Start off-screen
    @State private var alertOpacity: Double = 0 // Start fully transparent
    
    
    @State private var showCustomAlert = false
    @State private var alertIcon: String = ""
    @State private var alertTitle: String = ""
    @State private var alertDescription: String = ""
    
    @State private var isPlaying = false
    @State private var player: AVPlayer?
    
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    private func toggleAnswer(at index: Int) {
        if question.selectionType == .single {
            selectedAnswers = [index]
        } else {
            if selectedAnswers.contains(index) {
                selectedAnswers.remove(index)
            } else {
                selectedAnswers.insert(index)
            }
        }
        updateButtonAppearance()
    }
    
    private func updateButtonAppearance() {
        // Determine whether the button should be visible based on question type and number of selected answers
        let shouldShowButton: Bool
        switch question.selectionType {
        case .single:
            shouldShowButton = !selectedAnswers.isEmpty // Show button if any answer is selected
        case .multiple:
            shouldShowButton = selectedAnswers.count >= 2 // Show button if two or more answers are selected
        }
        
        withAnimation(.easeInOut) {
            buttonOffset = shouldShowButton ? 0 : 100 // Control slide
            buttonOpacity = shouldShowButton ? 1 : 0 // Control fade
        }
    }
    
    
    private func checkAnswer() {
        let correct = selectedAnswers == question.correctAnswers
        let remainingQuestions = totalQuestions - (questionIndex + 1)
        
        let notificationGenerator = UINotificationFeedbackGenerator()
        
        if correct {
            notificationGenerator.notificationOccurred(.success)
            alertIcon = "checkmark.circle.fill"
            alertTitle = NSLocalizedString("correct_answer", comment: "")
            
            // Custom message based on the number of remaining questions
            switch remainingQuestions {
            case 1:
                alertDescription = NSLocalizedString("one_question_left", comment: "")
            case 0:
                alertDescription = NSLocalizedString("youre_finished", comment: "")
            default:
                let formatString = NSLocalizedString("toast_description", comment: "")
                alertDescription = String(format: formatString, remainingQuestions)
            }
            
        } else {
            notificationGenerator.notificationOccurred(.error)
            alertIcon = "xmark.circle.fill"
            alertTitle = NSLocalizedString("wrong_answer_title", comment: "")
            alertDescription = NSLocalizedString("wrong_answer_description", comment: "")
        }
        showCustomAlert = true
        withAnimation(.bouncy(duration: 0.4)) {
            alertOffset = 0 // Slide down
            alertOpacity = 1
        }
        
        // Dismiss the custom alert after a delay and navigate if correct
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 0.3)) {
                alertOffset = -100 // Slide up
                alertOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showCustomAlert = false
                if correct {
                    onCorrectAnswer() // Trigger navigation to the next question
                }
            }
        }
    }

    
    
    
    //    private func checkAnswer() {
    //        if selectedAnswers == question.correctAnswers {
    //            print("Correct Answer for Question \(questionIndex + 1). Moving to next question.")
    //            showingAlert = true
    //        } else {
    //            print("Incorrect Answer for Question \(questionIndex + 1).")
    //            showingAlert = true
    //        }
    //    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    
                    ZStack {
                        if let player = player {
                                       VideoPlayer(player: player)
                                           .aspectRatio(16/9, contentMode: .fit)
                                           .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                           .padding()
                                   }

                                if !isPlaying {
                                    ZStack(alignment: .bottomTrailing) {
                                        Image(question.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                            .padding()
                                            
                                        Image(systemName: "play.circle.fill")
                                            .padding([.bottom, .trailing], 24.0)
                                            .font(.system(size: 56))
                                            .foregroundColor(Color.white)
                                    }
                                    .onTapGesture {
                                        isPlaying = true
                                        player?.play()
                                    }
         
                                }
                            }

                    VStack(alignment: .leading) {
                        Text(question.question)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack(alignment: .center) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.secondary)
                            Text(question.selectionType == .single ? "Select one answer" : "Select two answers")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            
                        }
                        .padding(.bottom, 16)
                        .padding(.top, 1)
                        
                        
                        ForEach(Array(question.options.indices), id: \.self) { index in
                            Button(action: {
                                let generator = UISelectionFeedbackGenerator()
                                generator.selectionChanged()
                                toggleAnswer(at: index)
                                
                            }) {
                                HStack {
                                    Image(systemName: selectedAnswers.contains(index) ? "checkmark.circle.fill": "circle")
                                        .contentTransition(.symbolEffect(.replace))
                                        .font(.system(size: 24))
                                        .foregroundColor(selectedAnswers.contains(index) ? .white : Color(UIColor.opaqueSeparator))
                                    Text(question.options[index])
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(selectedAnswers.contains(index) ? .white : Color(UIColor.label))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(4)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                    
                                }
                                
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
                                .background(selectedAnswers.contains(index) ? Color(red: 0.17, green: 0.34, blue: 0.97) : (colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground)))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            }
                            .padding(.bottom, 2)
                        }
                        
                        Spacer()
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                }
            }
            
            
            VStack {
                Spacer()
                Button(action: {
                    checkAnswer()
                    let generator = UIImpactFeedbackGenerator(style: .light)
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
                                RoundedRectangle(cornerRadius: 55) // 2
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
                            .clipShape(RoundedRectangle(cornerRadius: 55, style: .continuous))
                            .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)
                        
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    //                        Text("Next →")
                    //                            .fontWeight(.bold)
                    //                            .padding(.horizontal)
                    //                            .frame(height: 40.0)
                    //                            .frame(maxWidth: .infinity)
                })
                //                    .buttonStyle(.borderedProminent)
                //                    .cornerRadius(50)
                .offset(y: buttonOffset)
                .opacity(buttonOpacity)
                .padding(.horizontal)
            }
            .animation(.bouncy, value: buttonOffset)
            .animation(.easeInOut, value: buttonOffset)
            
            
            if showCustomAlert {
                CustomAlertView(icon: alertIcon, title: alertTitle, description: alertDescription)
                    .offset(y: alertOffset)
                    .opacity(alertOpacity)
                    .transition(.move(edge: .top))
                    .zIndex(1) // Ensure it's above other content
                
            }
            
            
        }
        .onAppear {
                    // Initialize the player when the view appears
                    self.player = AVPlayer(url: question.videoURL)
                }
        
        
        
        .navigationBarTitle(Text("Question \(questionIndex + 1) of \(totalQuestions)"), displayMode: .inline)
        .background(NavigationLink(destination: Text("Placeholder for next question"), isActive: $navigateToNextQuestion) { EmptyView() })
    }
}





// Define a mock question for preview purposes
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample question
        let sampleQuestion = Question(
            question: "Where can you bike in Copenhagen?",
            options: ["Paris", "London", "Berlin", "Madrid"],
            correctAnswers: Set([0]),
            selectionType: .multiple,
            imageName: "img_q1",
            videoURL: URL(string: "https://customer-9pt4qx20ydn5u5h2.cloudflarestream.com/5c34a4d6ff917aa2a99d037e5ba182cc/manifest/video.m3u8")!
        )
        
        QuestionView(
            question: sampleQuestion,
            totalQuestions: 1,
            questionIndex: 0,
            onCorrectAnswer: { print("Correct answer selected.") }
        )
    }
}

