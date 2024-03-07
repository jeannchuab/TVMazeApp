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
    
    /* Valid ISO Formats:
     2022-05-02T00:00+03:00
     2022-05-03 // Notice this ignores time
    */
    func dateFromISOString(_ isoString: String) -> Date? {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]  // ignores time!
        return isoDateFormatter.date(from: isoString)  // returns nil, if isoString is malformed.
    }
}
