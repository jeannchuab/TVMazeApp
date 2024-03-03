//
//  Date+Extensions.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import Foundation

extension Date {    
    var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    }
    
    var oneHundredTwentyYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -120, to: Date()) ?? Date()
    }
}
