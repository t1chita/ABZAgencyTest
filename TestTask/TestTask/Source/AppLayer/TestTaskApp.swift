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
    @StateObject var router = NavigationManager()
    @StateObject private var cameraManager = CameraManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                Group {
                    if networkManager.isConnected {
                        MainTabView(mainTabVM: MainTabViewModel())
                    } else {
                        NoInternetConnectionScreen()
                    }
                }
                .navigationDestination(for: NavigationManager.Destination.self) { destination in
                    switch destination {
                    case .result(let success):
                        ResultPage(
                            resultImage: success ? .success : .failure,
                            resultText:  success ? "User successfully registered" : "That email is already registered",
                            buttonText:  success ? "Got it" : "Try again"
                        )
                    }
                }
            }
                .environment(networkManager)
                .environmentObject(cameraManager)
                .environmentObject(router)
        }
    }
}
