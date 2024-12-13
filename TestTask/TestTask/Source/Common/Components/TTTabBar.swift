//
//  TTTabBar.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import SwiftUI

enum AppTabs: String, CaseIterable {
    case users = "Users"
    case signUp = "Sign Up"
    
    var icon: String {
        switch self {
        case .users:
            return "person.3.sequence.fill"
        case .signUp:
            return "person.crop.circle.fill.badge.plus"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: AppTabs
    var body: some View {
        HStack {
            ForEach(AppTabs.allCases, id: \.self) { tab in
                HStack(spacing: 8) {
                    Image(systemName: tab.icon)
                        .foregroundStyle(selectedTab == tab ? .mySecondary : .black60)
                        .frame(width: 40, height: 17)
                    
                    Text(tab.rawValue)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(selectedTab == tab ? .mySecondary : .black60)
                }
                .onTapGesture {
                    withAnimation {
                        selectedTab = tab

                    }
                }
                
                if tab == .users {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 45)
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(
            Rectangle()
                .foregroundStyle(.tabBarBackground)
        )
    }
}
