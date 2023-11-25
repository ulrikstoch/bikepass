//
//  Question.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import Foundation

enum SelectionType {
    case single
    case multiple
}

struct Question {
    let question: String
    let options: [String]
    let correctAnswers: Set<Int>
    let selectionType: SelectionType
}




