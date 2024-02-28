//
//  String+Extensions.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation

extension String {
    func removeHtmlTags() -> String {
        do {
            guard let data = self.data(using: .unicode) else {
                return self
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
    
    func formattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        guard let date: Date = dateFormatterGet.date(from: self) else { return "" }                                
        return dateFormatter.string(from: date)
    }
}
