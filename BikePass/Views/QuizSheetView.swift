//
//  QuizSheetView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI




struct QuizSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    let quiz: Quiz
    @State private var currentQuestionIndex = 0
    // Define a state to manage explicit navigation link activation
    @State private var activeLink: Int? = nil
    @State private var showQuizCompleteView = false
    @Environment(\.colorScheme) var colorScheme
    var viewModel: QuizViewModel
    var dismissAction: () -> Void // Add this line
    
    
    

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                colorScheme == .dark ? Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all) : Color(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
                
//                Color.red.edgesIgnoringSafeArea(.all)
                // Iterate through each question to prepare NavigationLink
                ForEach(0..<(quiz.questions.count + 1), id: \.self) { index in
                    NavigationLink(destination: questionView(index: index), tag: index, selection: $activeLink) {
                        EmptyView()
                        
                    }
                    .hidden()
                }

                
                // Present the current question
                questionView(index: currentQuestionIndex)
//                    .padding(.horizontal)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showQuizCompleteView) {
                QuizCompleteView(viewModel: viewModel, dismissAction: dismissAction)
            }
            
        }
    }
    
    
    @ViewBuilder
    private func questionView(index: Int) -> some View {
        if index < quiz.questions.count {
            // Return the question view for the current index
            QuestionView(question: quiz.questions[index], totalQuestions: quiz.questions.count, questionIndex: index) {
                // Navigate to the next question or the quiz completion view
                activeLink = index + 1 // Automatically navigate to the next "question"
            }
        } else {
            // When index equals quiz.questions.count, show the QuizCompleteView
            QuizCompleteView(viewModel: viewModel, dismissAction: dismissAction)
        }
    }

}







struct QuizSheetView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of QuizViewModel
        let viewModel = QuizViewModel()

        // Define a mock quiz for the preview
        let mockQuiz = Quiz(questions: [/* your mock questions here */])

        // Pass the viewModel to QuizSheetView
        QuizSheetView(quiz: mockQuiz, viewModel: viewModel, dismissAction: {
            print("Dismiss action for preview")
        })
    }
}

