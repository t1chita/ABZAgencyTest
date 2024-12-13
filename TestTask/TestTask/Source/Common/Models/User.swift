//
//  User.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation

// User structure representing a single user
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let positionId: Int
    let registrationTimestamp: Int
    let photo: String
    
    // Coding keys for the custom key names in JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case position
        case positionId = "position_id"
        case registrationTimestamp = "registration_timestamp"
        case photo
    }
}

extension User {
    static let MOCK_USER = User(
        id: 1,
        name: "Leanne West",
        email: "onie34@lubowitz.com",
        phone: "+380936050764",
        position: "Content manager",
        positionId: 2,
        registrationTimestamp: 1604494937,
        photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
    )
    
    static let ARRAY_MOCK_USERS = [
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        ),
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        ),
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        ),
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        ),
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        ),
        User(
            id: 1,
            name: "Leanne West",
            email: "onie34@lubowitz.com",
            phone: "+380936050764",
            position: "Content manager",
            positionId: 2,
            registrationTimestamp: 1604494937,
            photo: "https://frontend-test-assignment-api.abz.agency/images/users/5fa2a6596d3bb1.jpeg"
        )
    ]
}
