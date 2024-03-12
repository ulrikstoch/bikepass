//
//  QuizViewModel.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 10/03/2024.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var quizCompleted: Bool {
        didSet {
            UserDefaults.standard.set(quizCompleted, forKey: "quizCompleted")
            if quizCompleted {
                // Generate and store the issue date and unique ID when the quiz is completed
                let currentDate = Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                let formattedDate = formatter.string(from: currentDate)
                UserDefaults.standard.set(formattedDate, forKey: "bikePassIssueDate")

                let uniqueID = "DK" + UUID().uuidString.prefix(8)
                UserDefaults.standard.set(uniqueID, forKey: "bikePassID")
            }
        }
    }
    
    @Published var userName: String {
            didSet {
                UserDefaults.standard.set(userName, forKey: "userName")
            }
        }


    var bikePassIssueDate: String {
        UserDefaults.standard.string(forKey: "bikePassIssueDate") ?? "Unknown"
    }

    var bikePassID: String {
        UserDefaults.standard.string(forKey: "bikePassID") ?? "Unknown"
    }

    init() {
        self.quizCompleted = UserDefaults.standard.bool(forKey: "quizCompleted")
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
    }
}


