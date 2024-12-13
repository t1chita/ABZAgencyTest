//
//  TTRadioButton.swift
//  TestTask
//
//  Created by Temur Chitashvili on 12.12.24.
//

import SwiftUI

enum RadioButtonStyle {
    case smallSecondary
    case bigSecondary
    case mediumSecondary
    case graySecondary
}

struct TTSmallSecondaryRadioButton: View {
    let radioButtonStyle: RadioButtonStyle
    @State  var isButtonFilled: Bool = false
    
    var body: some View {
        if isButtonFilled {
            ZStack {
                Circle()
                    .foregroundStyle(.mySecondary)
                    .frame(width: 10, height: 10)
                    .padding(10)
                
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.mySecondary)
                    .frame(width: 20, height: 20)
            }
            .onTapGesture {
                withAnimation(.default) {
                    isButtonFilled = false
                }
            }
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundStyle(.mySecondary)
                .frame(width: 20, height: 20)
            
                .onTapGesture {
                    withAnimation(.default) {
                        isButtonFilled = true
                    }
                }
        }
    }
}

struct TTBigSecondaryRadioButton: View {
    let radioButtonStyle: RadioButtonStyle
    @State  var isButtonFilled: Bool = false
    
    var body: some View {
        if isButtonFilled {
            ZStack {
                Circle()
                    .foregroundStyle(.mySecondary)
                    .frame(width: 10, height: 10)
                    .padding(10)
                
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.mySecondary)
                    .frame(width: 20, height: 20)
            }
            .padding(14)
            .background(
                Circle()
                    .foregroundStyle(.mySecondary.opacity(0.1))
                    .frame(width: 48, height: 48)
            )
            .onTapGesture {
                withAnimation(.default) {
                    isButtonFilled = false
                }
            }
        } else {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundStyle(.mySecondary)
                .frame(width: 20, height: 20)
                .padding(14)
                .background(
                    Circle()
                        .foregroundStyle(.mySecondary.opacity(0.1))
                        .frame(width: 48, height: 48)
                )
                .onTapGesture {
                    withAnimation(.default) {
                        isButtonFilled = true
                    }
                }
        }
    }
    
}

struct TTMediumSecondaryRadioButton: View {
    let radioButtonStyle: RadioButtonStyle
    @State  var isButtonFilled: Bool = false
    
    var body: some View {
        if isButtonFilled {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundStyle(.mySecondary)
                .frame(width: 14, height: 14)
                .onTapGesture {
                    withAnimation(.default) {
                        isButtonFilled = false
                    }
                }
        } else {
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
                        isButtonFilled = true
                    }
                }
        }
    }
    
}

struct TTGraySecondaryRadioButton: View {
    let radioButtonStyle: RadioButtonStyle
    @State  var isButtonFilled: Bool = false
    
    var body: some View {
        if isButtonFilled {
            Circle()
                .stroke(lineWidth: 1)
                .foregroundStyle(.myGray)
                .frame(width: 14, height: 14)
                .onTapGesture {
                    withAnimation(.default) {
                        isButtonFilled = false
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
                        isButtonFilled = true
                    }
                }
        }
    }
}

#Preview {
    TTSmallSecondaryRadioButton(radioButtonStyle: .smallSecondary)
    TTBigSecondaryRadioButton(radioButtonStyle: .bigSecondary)
    TTMediumSecondaryRadioButton(radioButtonStyle: .mediumSecondary)
    TTGraySecondaryRadioButton(radioButtonStyle: .graySecondary)
}
