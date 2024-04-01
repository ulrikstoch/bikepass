//
//  InfoView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 11/03/2024.
//

import SwiftUI


func createCompositeText() -> Text {
    let partOne = Text("The ")
        .foregroundColor(Color.white.opacity(0.7))
    let partTwo: Text
    if #available(iOS 17.0, *) {
        partTwo = Text("unofficial").foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white.opacity(0.7), Color.white.opacity(0.9)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    } else {
        partTwo = Text("unofficial").foregroundColor(.white)
    }
    let partThree = Text(" biking license for biking in Copenhagen.")
        .foregroundColor(Color.white.opacity(0.7))
    
    return partOne + partTwo + partThree
}

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingShareSheet = false
    //    @AppStorage("selectedIconName") var selectedIconName: String = "AppIcon" // Fetching the selected icon name
    
    var body: some View {
        
        
        ZStack {
            colorScheme == .dark ? Color(UIColor.systemBackground)
                .ignoresSafeArea(): Color(UIColor.secondarySystemBackground).ignoresSafeArea()
            
            
            
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("BikePass")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 8.0)
                        //                                .padding(.top, 8.0)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            // Split the text into two parts: "The" + "unofficial" + "biking license for biking in Copenhagen."
                            // Apply the gradient only to the "unofficial" part.
                            Text("The ")
                                .foregroundColor(Color.white.opacity(0.7)) +
                            Text("unofficial").foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white.opacity(0.7), Color.white.opacity(0.9)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            ) +
                            Text(" biking license for biking in Copenhagen.")
                                .foregroundColor(Color.white.opacity(0.7))
                            
                            Text("Built to promote safety and ensure all cyclists have a good time exploring the city on two wheels.")
                                .foregroundColor(Color.white.opacity(0.7))
                            
                        }
                        .padding(.bottom, 8.0)
                    }
                    .padding(24)
                    .background(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.26, green: 0.42, blue: 0.96), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.17, green: 0.34, blue: 0.97), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    
                    
                    
                    VStack(spacing:0) {
                        Image("about_CB")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                            .padding(.bottom, 24.0)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Image("copenhagen_bicycles")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140)
                            Text("All videos and illustrations in BikePass are property of Copenhagen Bicycles and used with their permission")
                                .foregroundColor(Color.gray)
                        }
                        .padding(.horizontal, 23)
                        .padding(.bottom, 24)
                    }
                    .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    
                    
                    VStack {
                        Image("builtby")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 10.0)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Made in Copenhagen")
                                .font(.title2)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            Text("BikePass is a public service project built and designed by Ulrik Stoch Jensen. ")
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    }
                    .background(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    
                    
                    Text("BikePass © 2024, version 1.0.0")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    
                    
                    
                }
                .padding([.leading, .bottom, .trailing])
            }
        }
    }
}

#Preview {
    InfoView()
}


