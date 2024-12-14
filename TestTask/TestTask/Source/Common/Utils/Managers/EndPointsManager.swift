//
//  EndPointsManager.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation
import NetworkingPackage

/// Enum that manages API endpoints for the application.
enum EndPointsManager {
    case getUsers(page: Int, count: Int)
    case getPositions
    case getToken
}

extension EndPointsManager: EndPoint {
    // MARK: - EndPoint Protocol Implementation
    
    /// Host URL for the API.
    var host: String {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return "frontend-test-assignment-api.abz.agency"
        }
    }
    
    /// Scheme to be used for the API request (e.g., HTTP or HTTPS).
    var scheme: String {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return "https"
        }
    }
    
    /// Path for the API endpoint.
    var path: String {
        switch self {
        case .getUsers:
            return "/api/v1/users"
        case .getPositions:
            return "/api/v1/positions"
        case .getToken:
            return "/api/v1/token"
        }
    }
    
    /// HTTP method to be used for the request (GET, POST, etc.).
    var method: NetworkingPackage.RequestMethod {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return .get
        }
    }
    
    /// HTTP headers to be included in the request.
    var header: [String : String]? {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return nil // Add any headers if needed, for example authorization token
        }
    }
    
    /// Request body parameters to be sent with the API request.
    var body: [String : NetworkingPackage.AnyEncodable]? {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return nil // No body needed for GET requests
        }
    }
    
    /// Query parameters for the API request, if any.
    var queryParams: [String : NetworkingPackage.AnyEncodable]? {
        switch self {
        case .getUsers(let page, let count):
            return [
                "page": AnyEncodable(page),
                "count": AnyEncodable(count)
            ]
        case .getPositions, .getToken:
            return nil // No query parameters for these endpoints
        }
    }
    
    /// Path parameters for the API request, if any.
    var pathParams: [String : String]? {
        switch self {
        case .getUsers, .getPositions, .getToken:
            return nil // No path parameters needed
        }
    }
}
