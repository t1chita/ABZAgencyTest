//
//  AuthManager.swift
//  TestTask
//
//  Created by Temur Chitashvili on 14.12.24.
//

import Foundation
import NetworkingPackage

final class AuthManager: ObservableObject {
    @Published var authResponse: TokenResponse?
    static let shared = AuthManager()
    
    private init() {}
    
    
    func getToken(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.sendRequest(endPoint: EndPointsManager.getToken) { [weak self] (result: Result<TokenResponse, NetworkError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let success):
                    self?.authResponse = success
                    completion(true)
                case .failure(let failure):
                    print("Can't Get Token")
                    completion(false)
                }
            }
        }
    }
}
