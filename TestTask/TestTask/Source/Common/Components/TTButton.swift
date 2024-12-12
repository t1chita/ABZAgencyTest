//
//  TTButton.swift
//  TestTask
//
//  Created by Temur Chitashvili on 12.12.24.
//

import SwiftUI

enum ButtonStyle {
    case primaryDark
    case primary
    case primaryDisabled
    case secondaryUnfilled
    case secondaryFilled
    case secondaryDisabled
}


struct TTButton: View {
    let buttonText: String
    let buttonStyle: ButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .foregroundStyle(textColor)
                .font(.system(size: fontSize, weight: .semibold))
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(
                    Capsule()
                        .cornerRadius(24)
                        .foregroundStyle(backgroundColor)
                )
        }
    }
    
    var verticalPadding: CGFloat {
        switch buttonStyle {
        case .primaryDark, .primary, .primaryDisabled:
            12
        case .secondaryUnfilled, .secondaryFilled, .secondaryDisabled:
            8
        }
    }
    
    var horizontalPadding: CGFloat {
        switch buttonStyle {
        case .primaryDark, .primary, .primaryDisabled:
            24
        case .secondaryUnfilled, .secondaryFilled, .secondaryDisabled:
            16
        }
    }
    
    var backgroundColor: Color {
        switch buttonStyle {
        case .primaryDark:
                .myPrimaryDark
        case .primary:
                .myPrimary
        case .primaryDisabled:
                .myGray
        case .secondaryUnfilled, .secondaryDisabled:
                .clear
        case .secondaryFilled:
                .mySecondary.opacity(0.1)
        }
    }
    
    var textColor: Color {
        switch buttonStyle {
        case .primaryDark, .primary:
                .black87
        case .primaryDisabled, .secondaryDisabled:
                .black48
        case .secondaryUnfilled, .secondaryFilled:
                .mySecondaryDark
        }
    }
    
    var fontSize: CGFloat {
        switch buttonStyle {
        case .primaryDark, .primary, .primaryDisabled:
            18
        case .secondaryUnfilled, .secondaryFilled, .secondaryDisabled:
            16
        }
    }
    
}

#Preview {
    TTButton(buttonText: "Button", buttonStyle: .primary) {
        print("Button")
    }
    TTButton(buttonText: "Button", buttonStyle: .primaryDark) {
        print("Button")
    }
    TTButton(buttonText: "Button", buttonStyle: .primaryDisabled) {
        print("Button")
    }
    TTButton(buttonText: "Button", buttonStyle: .secondaryUnfilled) {
        print("Button")
    }
    TTButton(buttonText: "Button", buttonStyle: .secondaryFilled) {
        print("Button")
    }
    TTButton(buttonText: "Button", buttonStyle: .secondaryDisabled) {
        print("Button")
    }
}
