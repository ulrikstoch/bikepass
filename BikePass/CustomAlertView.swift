//
//  CustomAlertView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 06/02/2024.
//

import SwiftUI

struct CustomAlertView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(icon == "checkmark.circle.fill" ? .green : .red)
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .multilineTextAlignment(.center)
            }

        }
        .padding(10.0)
        .padding(.trailing, 15)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(50)
        .shadow(color: .black.opacity(0.30), radius: 5, x: 0, y: 3)
    }
}



#Preview {
    CustomAlertView(icon: "checkmark.circle.fill", title: "Correct Answer!", description: "Only 7 questions to go")
                .padding()
                .previewLayout(.sizeThatFits)
}
