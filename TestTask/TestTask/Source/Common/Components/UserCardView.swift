//
//  UserCardView.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import SwiftUI

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
