//
//  SuccessResponse.swift
//  TestTask
//
//  Created by Temur Chitashvili on 14.12.24.
//

import Foundation

struct SuccessResponse: Codable {
    let success: Bool
    let user_id: Int?
    let message: String
}

struct ErrorResponse: Codable {
    let success: Bool
    let message: String
    let fails: [String]?
}
