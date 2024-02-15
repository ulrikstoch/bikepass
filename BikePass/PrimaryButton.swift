//
//  PrimaryButton.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 15/02/2024.
//

import SwiftUI

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

struct PrimaryButton: View {
    var action: () -> Void
    var label: String
    @Environment(\.colorScheme) var colorScheme // Use environment to access color scheme

    // Gradient for Light Mode


    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 62)
                .background(
                    colorScheme == .dark ? darkModeGradient : lightModeGradient
                )
            
                .cornerRadius(20)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.white.opacity(0.95), radius: 0, x: 0, y: 1)
            
            Button(action: action, label: {
                
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
                    
                    
                    
                    
                    
                    Text(label)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    
                }
            })
            .padding(.horizontal, 5)
            
        }
    }
}


#Preview {
    PrimaryButton(action: {
        // This is where you define what the button should do when tapped.
        // For preview purposes, this can be left empty or just print a message.
        print("Button tapped")
    }, label: "Start Quiz")
    .previewLayout(.sizeThatFits)
}
