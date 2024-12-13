//
//  UsersResponse.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//


import Foundation

// Root structure representing the entire response
struct UsersResponse: Codable {
    let success: Bool
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let page: Int
    let links: Links
    let users: [User]
    
    // Coding keys for the custom key names in JSON
    enum CodingKeys: String, CodingKey {
        case success
        case totalPages = "total_pages"
        case totalUsers = "total_users"
        case count
        case page
        case links
        case users
    }
}

