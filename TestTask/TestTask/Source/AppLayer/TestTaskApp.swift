//
//  TestTaskApp.swift
//  TestTask
//
//  Created by Temur Chitashvili on 12.12.24.
//

import SwiftUI

@main
struct TestTaskApp: App {
    @State private var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            Group {
                if networkManager.isConnected {
                    MainTabView(mainTabVM: MainTabViewModel())
                } else {
                    NoInternetConnectionScreen()
                }
            }
                .environment(networkManager)
        }
    }
}
