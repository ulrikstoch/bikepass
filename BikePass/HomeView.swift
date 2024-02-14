//
//  HomeView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("header")
                .resizable()

                .scaledToFit()
                .cornerRadius(30)
            
            Text("Welcome to \nCopenhagen 👋")
                .font(.system(size: 37))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 5.0)
                .padding(.top, 16.0)
            
            Text("Before you begin your two-wheeled journey, we’d like to make sure you know how rules of biking in Copenhagen, to ensure you and other cyclists safety.")
                .font(.system(size: 17))
                .fontWeight(.regular)
            
                .foregroundColor(colorScheme == .dark ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                .multilineTextAlignment(.leading)
                .lineSpacing(5)
            
            Spacer()
            
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
//                    QuizView(quiz: quiz)
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
                        

                        Text("Get started")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        
                    }
                })
                .padding(.horizontal, 5)
                
            }
        }
        .padding(.all, 24.0)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
