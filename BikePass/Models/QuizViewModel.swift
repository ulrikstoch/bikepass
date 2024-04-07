//
//  QuizViewModel.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 10/03/2024.
//

import Foundation
import TelemetryClient

class QuizViewModel: ObservableObject {
    @Published var quizCompleted: Bool {
        didSet {
            UserDefaults.standard.set(quizCompleted, forKey: "quizCompleted")
            if quizCompleted {
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                let formattedDate = formatter.string(from: currentDate)
                UserDefaults.standard.set(formattedDate, forKey: "bikePassIssueDate")

                let numberPart = String(Int.random(in: 10000000...99999999)) // Generates a random 8-digit number
                let uniqueID = "DK" + numberPart
                UserDefaults.standard.set(uniqueID, forKey: "bikePassID")
                TelemetryManager.send("BikePassCreated", with: ["BikePassID": bikePassID])
            }
        }
    }
    
    @Published var userName: String {
            didSet {
                UserDefaults.standard.set(userName, forKey: "userName")
            }
        }
    
    @Published var userCountry: String {
        didSet {
            UserDefaults.standard.set(userCountry, forKey: "userCountry")

            let components = userCountry.components(separatedBy: " ")
            guard components.count >= 3 else {
                print("Unexpected format of userCountry: \(userCountry)")
                return
            }

            // Assuming the country code is the second component
            let countryCode = components[1]
            let usLocale = Locale(identifier: "en_US")
            let countryNameInEnglish = usLocale.localizedString(forRegionCode: countryCode) ?? ""

            TelemetryManager.send("CountrySelected", with: ["Country": countryNameInEnglish])
        }
    }




    


    var bikePassIssueDate: String {
        UserDefaults.standard.string(forKey: "bikePassIssueDate") ?? "Unknown"
    }

    var bikePassID: String {
        UserDefaults.standard.string(forKey: "bikePassID") ?? "Unknown"
    }
    
    var countryEmoji: String {
        if let index = userCountry.firstIndex(of: " ") {
            return String(userCountry[..<index])
        }
        return userCountry  // Return the full string if there's no space (it might be just the emoji)
    }
    
    var userCountryWithoutEmoji: String {
        let components = userCountry.components(separatedBy: " ")
        guard components.count >= 3 else {
            print("Unexpected format of userCountry: \(userCountry)")
            return ""
        }

        // Assuming the third component is the country name
        let countryName = components.dropFirst(2).joined(separator: " ")
        return countryName
    }








    init() {
        self.quizCompleted = UserDefaults.standard.bool(forKey: "quizCompleted")
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.userCountry = UserDefaults.standard.string(forKey: "userCountry") ?? ""

        if self.userCountry.isEmpty {
            let locale = Locale.current
            if let countryCode = locale.regionCode, let countryName = locale.localizedString(forRegionCode: countryCode) {
                // Include the country code explicitly
                self.userCountry = "\(countryFlag(countryCode: countryCode)) \(countryCode) \(countryName)"
            }
        }
    }


    
    private func countryFlag(countryCode: String) -> String {
            return countryCode
                .unicodeScalars
                .map {
                    127397 + $0.value
                }
                .compactMap(UnicodeScalar.init)
                .map(String.init)
                .joined()
        }

}


