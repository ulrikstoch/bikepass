//
//  Question.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 08/07/2023.
//

import Foundation

enum SelectionType: Hashable {
    case single
    case multiple
}

struct Question: Hashable {
    let question: String
    let options: [String]
    let correctAnswers: Set<Int>
    let selectionType: SelectionType
    var imageName: String
    let videoURL: URL
}




