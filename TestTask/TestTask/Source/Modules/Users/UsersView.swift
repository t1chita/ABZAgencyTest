//
//  UsersView.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import SwiftUI

struct UsersView: View {
    @StateObject var usersVM: UsersViewModel
    @State private var isLoading: Bool = false
    var body: some View {
        if !usersVM.users.isEmpty {
            usersList()
        } else {
            weHaveNotUsersYet()
        }
    }
    
    private func weHaveNotUsersYet() -> some View {
        VStack {
            Image(.noUsers)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text("There are no users yet")
        }
    }
    
    private func usersList() -> some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(usersVM.users) { user in
                        UserCardView(user: user)
                            .onAppear {
                                // Check if the last item is appearing
                                if user.id == usersVM.users.last?.id {
                                    loadMoreUsers()
                                }
                            }
                        
                        Divider()
                    }
                }
            }
            
            if isLoading {
                ProgressView()
                    .padding(.vertical)
            }
        }
        .padding(.horizontal)
    }
    
    private func loadMoreUsers() {
        guard !isLoading else { return } // Avoid triggering multiple requests
        
        isLoading = true // Start loading
        
        // Trigger API call to load more users
        usersVM.getMoreUser { success in
            isLoading = false // Stop loading
        }
        
        if usersVM.isServerUsersEmpty {
            isLoading = false // Stop loading
        }
    }
}
