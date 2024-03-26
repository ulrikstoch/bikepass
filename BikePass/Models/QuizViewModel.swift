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
                TelemetryManager.send("CountrySelected", with: ["Country": userCountryWithoutEmoji])
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
            if components.count > 1 {
                return components.dropFirst().joined(separator: " ")
            }
            return userCountry // Return the original string if there's no space
        }

    init() {
        self.quizCompleted = UserDefaults.standard.bool(forKey: "quizCompleted")
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.userCountry = UserDefaults.standard.string(forKey: "userCountry") ?? ""

        // Set a recommended country based on the device's current locale
        if self.userCountry.isEmpty {
            let locale = Locale.current
            if self.userCountry.isEmpty {
                        let locale = Locale.current
                        if let countryCode = locale.regionCode {
                            self.userCountry = "\(countryFlag(countryCode: countryCode)) \(locale.localizedString(forRegionCode: countryCode) ?? "")"
                        }
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


