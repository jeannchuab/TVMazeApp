//
//  String+Extensions.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation
import RegexBuilder

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
    
    var isValidEmail: Bool {
        if #available(iOS 16, *) {
            let emailRegex = Regex {
                OneOrMore {
                    CharacterClass(
                        .anyOf("._%+-"),
                        ("A"..."Z"),
                        ("0"..."9"),
                        ("a"..."z")
                    )
                }
                "@"
                OneOrMore {
                    CharacterClass(
                        .anyOf("-"),
                        ("A"..."Z"),
                        ("a"..."z"),
                        ("0"..."9")
                    )
                }
                "."
                Repeat(2...64) {
                    CharacterClass(
                        ("A"..."Z"),
                        ("a"..."z")
                    )
                }
            }
            
            return self.wholeMatch(of: emailRegex) != nil
            
        } else {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: self)
        }
    }
}
