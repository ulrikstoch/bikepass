//
//  QuizSheetView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI


struct QuizSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    let quiz: Quiz
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswers = Set<Int>()
    @State private var showingAlert = false
    @State private var alertTitle = ""

    private func toggleAnswer(at index: Int) {
        switch quiz.questions[currentQuestionIndex].selectionType {
        case .single:
            selectedAnswers = [index]
        case .multiple:
            if selectedAnswers.contains(index) {
                selectedAnswers.remove(index)
            } else {
                selectedAnswers.insert(index)
            }
        }
    }


    private func nextQuestion() {
        if selectedAnswers == quiz.questions[currentQuestionIndex].correctAnswers {
            alertTitle = "Correct!"
            if currentQuestionIndex < quiz.questions.count - 1 {
                currentQuestionIndex += 1
            }
        } else {
            alertTitle = "Wrong answer. Try again"
        }
        showingAlert = true
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(quiz.questions[currentQuestionIndex].question)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            
            VStack {
                ForEach(Array(quiz.questions[currentQuestionIndex].options.indices), id: \.self) { index in
                    Button(action: {
                        toggleAnswer(at: index)
                    }) {
                        HStack {
                            Text(quiz.questions[currentQuestionIndex].options[index])
                                .foregroundColor(Color(UIColor.label))
                                .padding(.vertical, 6.0)
                            Spacer()
                            if selectedAnswers.contains(index) {
                                Image(systemName: "checkmark.circle.fill")
                                
                            }
                        }
                        .padding()
 
                        .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                        .cornerRadius(13)
                    }
                }
            }


            Button(action: nextQuestion, label: {
                    Text("Next")
                        .font(.headline)
                        .frame(height: 40.0)
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)

            Spacer()

            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                dismissButton: .default(Text("OK")) {
                    if alertTitle == "Correct!" {
                        selectedAnswers = Set<Int>()
                    }
                }
            )
        }
        .navigationTitle("Question \(currentQuestionIndex + 1) of \(quiz.questions.count)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}


struct QuizSheetView_Previews: PreviewProvider {
    static var previews: some View {
        QuizSheetView(quiz: quiz)
    }
}
