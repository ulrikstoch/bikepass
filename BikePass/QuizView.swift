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
        selectionType: .multiple
        
    ),
    Question(
        question: "How do you ride if you’re more than one person?",
        options: ["Side-by-side", "In a line behind each other", "Doesn’t matter"],
        correctAnswers: [1],
        selectionType: .single
    ),
    Question(
        question: "What do you do before overtaking?",
        options: ["Nothing", "Yell at the person in front to make sure they know you’re overtaking", "Look behind you to make sure there’s not other cyclists about to overtake you"],
        correctAnswers: [2],
        selectionType: .single
    ),
    Question(
        question: "What do you do when you hear a bell behind you?",
        options: ["Pull to the right and let the person overtake", "Slow down and wait for the person to overtake", "Ignore it", "Ring my bell"],
        correctAnswers: [0],
        selectionType: .single
    ),
    Question(
        question: "You want to stop in bike lane or road – what do you do?",
        options: ["Just stop", "Raise one of your hands and stop", "Raise your left hand and pull to the right", "Raise your right hand and pull to the right"],
        correctAnswers: [2],
        selectionType: .single
    ),
    Question(
        question: "How do you turn to the right?",
        options: ["Indicate with your right arm and then turn right", "Just turn to the right", "Indicate with your left arm and then turn right"],
        correctAnswers: [0],
        selectionType: .single
    ),
    Question(
        question: "How do you make a left turn?",
        options: ["Make a direct left turn", "Cross the street, stop and wait for green again.", "Use the pedetrian crosswalk"],
        correctAnswers: [1],
        selectionType: .single
    ),

])


struct QuizView: View {
    let quiz: Quiz
    @State private var showingQuizSheet = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Spacer()
            Image("bikepass_quiz")
            Spacer()
            VStack(spacing: 20) {
                
                Button(action: {showingQuizSheet = true}, label: {
                        Text("Start Quiz")
                            .font(.headline)
                            .frame(height: 40.0)
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                
                Button("Watch instructional video ") {
                    showingQuizSheet = true
                }
                .buttonStyle(.borderless)
            }
            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))

        .sheet(isPresented: $showingQuizSheet) {
            NavigationView {
                QuizSheetView(quiz: quiz)
            }
        }
    }
}



struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(quiz: quiz)
    }
}
