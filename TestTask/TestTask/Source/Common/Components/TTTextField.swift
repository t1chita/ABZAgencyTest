import SwiftUI

enum TextFieldStyles {
    case normal
    case error
}

struct TTTextField: View {
    let placeHolder: String
    let supportingText: String
    let errorText: String?
    @Binding var text: String
    var isValid: () -> Bool
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var hasUserTappedTextField: Bool = false
    @State private var style: TextFieldStyles = .normal

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                // Floating Placeholder
                if !isTextFieldFocused && !text.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(style == .error ? .error : (isTextFieldFocused ? .mySecondary : .myGray))
                        .offset(y: -25)
                        .scaleEffect(0.8, anchor: .leading)
                } else {
                    Text(placeHolder)
                        .foregroundColor(style == .error ? .error : (isTextFieldFocused ? .mySecondary : .myGray))
                        .offset(y: !isTextFieldFocused  ? 0: -25)
                        .scaleEffect(!isTextFieldFocused ? 1: 0.8, anchor: .leading)
                }
                // TextField
                TextField("", text: $text, prompt: nil)
                    .focused($isTextFieldFocused)
                    .padding(.top, isTextFieldFocused ? 8 : 0)
                    .foregroundColor(style == .error ? .error : .black87)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(
                        style == .error ? Color.red : (isTextFieldFocused ? Color.mySecondary : Color.myGray),
                        lineWidth: 1
                    )
            )
            
            // Supporting or Error Text
            Text(style == .error ? (errorText ?? "") : supportingText)
                .foregroundColor(style == .error ? .error : .gray)
                .font(.footnote)
                .padding(.leading, 16)
        }
        .onChange(of: isTextFieldFocused) { _, newValue in
            if newValue && !hasUserTappedTextField {
                hasUserTappedTextField = true
                print("User tapped the text field for the first time!")
            }
        }
        .onChange(of: text) { _, newValue in
            if hasUserTappedTextField && newValue == "" {
                style = .error
            } else {
                style = isValid() ? .normal : .error
            }
        }
        .animation(.default, value: isTextFieldFocused)
    }
}
