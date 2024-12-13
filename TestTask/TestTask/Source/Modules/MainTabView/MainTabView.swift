//
//  MainTabView.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var mainTabVM: MainTabViewModel  // Use ViewModel

    var body: some View {
        VStack {
            TabView(selection: $mainTabVM.selectedTab) {
                UsersView(usersVM: UsersViewModel())
                    .tag(AppTabs.users)
                    .toolbarVisibility(.hidden, for: .tabBar)

                SignUpView(signUpVM: SignUpViewModel())
                    .tag(AppTabs.signUp)
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            
            CustomTabBar(selectedTab: $mainTabVM.selectedTab)
        }
        .ignoresSafeArea()
    }
}


