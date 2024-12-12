import SwiftUI

enum TextFieldStyles {
    case normal
    case error
}

struct TTTextField: View {
    let placeHolder: String
    let supportingText: String
    let style: TextFieldStyles
    let errorText: String?

    @FocusState private var isTextFieldFocused: Bool
    @State var text: String = ""

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
        .animation(.default, value: isTextFieldFocused)
    }
}

#Preview {
    VStack {
        TTTextField(placeHolder: "Label", supportingText: "Supporting Text", style: .normal, errorText: nil)
        TTTextField(placeHolder: "Label", supportingText: "Error Text", style: .error, errorText: "Error Text")
    }
    .padding()
}
