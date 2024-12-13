//
//  Links.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation

// Links structure representing pagination URLs
struct Links: Codable {
    let nextUrl: String?
    let prevUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case nextUrl = "next_url"
        case prevUrl = "prev_url"
    }
}
