//
//  QuizCompleteView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 06/02/2024.
//

import SwiftUI

struct QuizCompleteView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    @State private var imageScale: CGFloat = 0.2 // Start with a scaled-down image
    @State private var textOpacity: Double = 0 // Start with invisible text and button
    @State private var fieldOpacity: Double = 0 // Start with invisible text and button
    @State private var buttonOpacity: Double = 0 // Start with invisible text and button
    @ObservedObject var viewModel: QuizViewModel


//    var viewModel: QuizViewModel
    var dismissAction: () -> Void
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Image(colorScheme == .dark ? "complete_dark" : "complete_light")
                .scaleEffect(imageScale)
                .onAppear {
                    withAnimation(.bouncy(duration: 0.6)) {
                        imageScale = 1 // Scale to normal size
                    }
                    withAnimation(.easeIn(duration: 1).delay(0.4)) {
                        textOpacity = 1 // Fade in text and button after the image scales
                    }
                    withAnimation(.easeIn(duration: 1).delay(0.6)) {
                        fieldOpacity = 1 // Fade in text and button after the image scales
                    }
                    withAnimation(.easeIn(duration: 1).delay(1)) {
                        buttonOpacity = 1 // Fade in text and button after the image scales
                    }
                }
            
            VStack(spacing: 8) {
                Text("Test completed!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .opacity(textOpacity)
                
                Text("We look forward to seeing you on the bike lanes of Copenhagen.")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
    //                .padding(.bottom, 40.0)
                    .lineLimit(2)
                    .padding(.horizontal, 32.0)
                    .opacity(textOpacity)
            }

//
            

            
            Spacer()
            TextField("Please enter your full name", text: $viewModel.userName)
                .textContentType(.name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .opacity(fieldOpacity)
                .overlay(
                    HStack {
                        Spacer()
                        if !viewModel.userName.isEmpty {
                            Button(action: {
                                viewModel.userName = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        
                    }
                    .opacity(fieldOpacity)
                )
//                .padding(.bottom)


            Button(action: {
                viewModel.quizCompleted = true
                dismissAction()
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
                      .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                      .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)

                      
                          

                    
                    Text("Show BikePass")
                        .font(.headline)
                        .foregroundColor(viewModel.userName.isEmpty ? Color.white.opacity(0.2) : Color.white)
                    
                    
                }
                .disabled(viewModel.userName.isEmpty)
                .opacity(buttonOpacity)
            })
//            .padding(.horizontal, 5)
            .padding(.bottom)
            
            
        }
//        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
    }
}

struct QuizCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of QuizViewModel
        let viewModel = QuizViewModel()

        // Pass the viewModel to QuizCompleteView
        QuizCompleteView(viewModel: viewModel, dismissAction: {
            print("Dismiss action triggered")
        })
    }
}

