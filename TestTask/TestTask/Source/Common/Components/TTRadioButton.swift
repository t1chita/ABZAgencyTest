//
//  TTRadioButton.swift
//  TestTask
//
//  Created by Temur Chitashvili on 12.12.24.
//

import SwiftUI

enum RadioButtonStyle {
    case mediumSecondary
    case graySecondary
}

struct TTRadioButton: View {
    let radioButtonStyle: RadioButtonStyle
    var isButtonFilled: Bool
    let action: () -> Void
    
    var body: some View {
        switch radioButtonStyle {
        case .mediumSecondary:
            if isButtonFilled {
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundStyle(.mySecondary)
                    .frame(width: 14, height: 14)
                    .onTapGesture {
                        withAnimation(.default) {
                            action()
                        }
                    }
            } else {
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.myGray)
                    .frame(width: 14, height: 14)
                
                    .onTapGesture {
                        withAnimation(.default) {
                            action()
                        }
                    }
            }
            
        case .graySecondary:
            if isButtonFilled {
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundStyle(.mySecondary)
                    .frame(width: 14, height: 14)
                    .padding(17)
                    .background(
                        Circle()
                            .foregroundStyle(.mySecondary.opacity(0.1))
                            .frame(width: 48, height: 48)
                    )
                
                    .onTapGesture {
                        withAnimation(.default) {
                            action()
                        }
                    }
            } else {
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.myGray)
                    .frame(width: 14, height: 14)
                    .padding(17)
                    .background(
                        Circle()
                            .foregroundStyle(.mySecondary.opacity(0.1))
                            .frame(width: 48, height: 48)
                    )
                    .onTapGesture {
                        withAnimation(.default) {
                            action()
                        }
                    }
            }
        }
    }
}
