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
    @State var weHaveUsers: Bool = true
    var body: some View {
        if weHaveUsers {
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

struct UserCardView: View {
    let user: User
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: user.photo)!) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.black87)
                    
                    Text(user.position)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.black60)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.email)
                        .foregroundStyle(.black87)
                        .font(.system(size: 14, weight: .regular))
                    
                    Text(user.phone.formattedPhoneNumber())
                        .foregroundStyle(.black87)
                        .font(.system(size: 14, weight: .regular))
                }
            }
            
            Spacer()
        }
    }
}

extension String {
    func formattedPhoneNumber() -> String {
        // Remove non-numeric characters from the string
        let digits = self.filter { $0.isNumber }
        
        // Ensure the phone number has exactly 12 digits (for a Ukrainian number with country code)
        guard digits.count == 12 else {
            return self // Return original string if it doesn't have 12 digits
        }
        
        // Create string indices to split the phone number
        let start = digits.startIndex
        let firstThree = digits.index(start, offsetBy: 3)
        let firstSix = digits.index(start, offsetBy: 6)
        let firstEight = digits.index(start, offsetBy: 8)
        
        // Format the phone number as +38 (XXX) XXX XX XX
        let formatted = "+38 (\(digits[start..<firstThree])) \(digits[firstThree..<firstSix]) \(digits[firstSix..<firstEight]) \(digits[firstEight..<digits.endIndex])"
        
        return formatted
    }
}
#Preview {
    MainTabView(mainTabVM: MainTabViewModel())
}
