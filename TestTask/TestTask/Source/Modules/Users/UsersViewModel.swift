//
//  UsersViewModel.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//
import Foundation
import NetworkingPackage

final class UsersViewModel: ObservableObject {
    @Published var getUsersResponse: UsersResponse?
    @Published var page: Int = 1
    @Published var users: [User] = []
    @Published var isServerUsersEmpty: Bool = false
    
    
    init() {
        getUsers() { _ in }
    }
    
    private func getUsers(completion: @escaping (Bool) -> Void) {
        NetworkService.shared.sendRequest(endPoint: EndPointsManager.getUsers(page: page, count: 6)) { [weak self] (result: Result<UsersResponse, NetworkError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let success):
                    self?.users.append(contentsOf: success.users)
                    self?.getUsersResponse = success
                    completion(true)
                case .failure(let failure):
                    print("Can't Fetch Users \(failure.customMessage)")
                    if failure.customMessage == "Status Code Error" {
                        self?.isServerUsersEmpty = true
                    }
                    completion(false)
                }
            }
        }
    }
    
    func getMoreUser(completion: @escaping (Bool) -> Void) {
        if !isServerUsersEmpty {
            page += 1
            getUsers(completion: completion)
            print("Get More")
        } else {
            print("Cant Fetch Server Users Anymore")
        }
    }
}
