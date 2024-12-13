//
//  MainTabViewModel.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation

final class MainTabViewModel: ObservableObject {
    @Published var selectedTab: AppTabs = .users
}
