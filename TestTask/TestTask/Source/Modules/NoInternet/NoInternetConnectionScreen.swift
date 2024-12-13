//
//  NoInternetConnectionScreen.swift
//  TestTask
//
//  Created by Temur Chitashvili on 12.12.24.
//

import SwiftUI

struct NoInternetConnectionScreen: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.noInternet)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text("There is no internet connection")
            
            TTButton(
                buttonText: "Try Again",
                buttonStyle: .primary) {
                    print("Try Again")
                }
        }
    }
}

#Preview {
    NoInternetConnectionScreen()
}
