//
//  PositionsResponse.swift
//  TestTask
//
//  Created by Temur Chitashvili on 14.12.24.
//

import Foundation

// Root response structure
struct PositionsResponse: Codable {
    let success: Bool
    let positions: [Position]
}

// Individual position structure
struct Position: Codable, Identifiable {
    let id: Int
    let name: String
}
