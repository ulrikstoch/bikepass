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
    var dismissAction: () -> Void
    
    
    var body: some View {
        VStack {
            Spacer()
            Image(colorScheme == .dark ? "complete_dark" : "complete_light")
                .padding(.bottom)
                .scaleEffect(imageScale)
                .onAppear {
                    withAnimation(.bouncy(duration: 0.6)) {
                        imageScale = 1 // Scale to normal size
                    }
                    withAnimation(.easeIn(duration: 1).delay(0.4)) {
                        textOpacity = 1 // Fade in text and button after the image scales
                    }
                }
            
            Text("Congratulations!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom)
                .opacity(textOpacity)
            
            Text("You answered all questions correctly. We look forward to seeing you on the bike lanes of Copenhagen.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .opacity(textOpacity)
            
            Spacer()
            Button(action: {
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
                      .cornerRadius(15)
                      .shadow(color: .black.opacity(0.35), radius: 1.5, x: 0, y: 2)

                      
                          

                    
                    Text("Show BikePass")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    
                }
                .opacity(textOpacity)
            })
            .padding(.horizontal, 5)
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
    }
}

#Preview {
    QuizCompleteView(dismissAction: {
        print("Dismiss action triggered")
    })
}
