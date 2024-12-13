//
//  NetworkManager.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//


import Foundation
import Network

@Observable
final class NetworkManager {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
