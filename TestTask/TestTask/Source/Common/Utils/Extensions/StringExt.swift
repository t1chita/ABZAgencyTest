//
//  StringExt.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation

extension String {
    func formattedPhoneNumber() -> String {
        // Remove non-numeric characters from the string
        let digits = self.filter { $0.isNumber }
        
        // Ensure the phone number has exactly 12 digits (for a Ukrainian number with country code)
        guard digits.count == 12 else {
            return self // Return original string if it doesn't have 12 digits
        }
        
        // Create string indices to split the phone number
        let start = digits.startIndex
        let firstThree = digits.index(start, offsetBy: 3)
        let firstSix = digits.index(start, offsetBy: 6)
        let firstEight = digits.index(start, offsetBy: 8)
        
        // Format the phone number as +38 (XXX) XXX XX XX
        let formatted = "+38 (\(digits[start..<firstThree])) \(digits[firstThree..<firstSix]) \(digits[firstSix..<firstEight]) \(digits[firstEight..<digits.endIndex])"
        
        return formatted
    }
}
