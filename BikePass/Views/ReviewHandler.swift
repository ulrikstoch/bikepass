//
//  ReviewHandler.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 11/03/2024.
//

import Foundation
import UIKit

class ReviewHandler {
    
    static func requestReviewManually() {
      let url = "https://apps.apple.com/app/id6480235107?action=write-review"
      guard let writeReviewURL = URL(string: url)
          else { fatalError("Expected a valid URL") }
      UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
