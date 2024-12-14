//
//  SignUpView.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signUpVM: SignUpViewModel
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var router: NavigationManager
    @State private var isLoading = false
    @State private var showActionSheet = false
    @State private var isImagePickerPresented = false
    @State private var showCameraPermissionAlert = false
    @State private var hasUserTappedCameraButton = false
    @State private var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: 24) {
                    userInfoTextFields()
                    
                    selectPositions()
                    
                    uploadingPhotoButton()
                    
                    TTButton(
                        buttonText: "Sign up",
                        buttonStyle: signUpVM.isFormValid ? .primary : .primaryDisabled) {
                            isLoading = true
                            AuthManager.shared.getToken { success in
                                if success {
                                    signUpVM.submitSignUpForm { success, message in
                                        print(message)
                                        if success {
                                            isLoading = false
                                            router.navigate(to: .result(success: true))
                                            print("Navigate To Success Page")
                                        } else {
                                            isLoading = false
                                            router.navigate(to: .result(success: false))
                                            print("Navigate To Failure Page")
                                        }
                                    }
                                } else {
                                    isLoading = false
                                    print("Can't Get Token In Signup Page")
                                }
                            }
                        }
                        .disabled(!signUpVM.isFormValid)
                }
                .padding(.horizontal)
            }
            
            if isLoading {
                Color
                    .myGray.opacity(0.6)
                    .ignoresSafeArea()
            }
            if isLoading {
                ProgressView()
            }
        }
    }
    
    private func userInfoTextFields() -> some View {
        VStack {
            TTTextField(
                placeHolder: "Your Name",
                supportingText: "",
                errorText: "Required Field",
                text: $signUpVM.name,
                isValid: { signUpVM.isNameValid }
            )
            
            TTTextField(
                placeHolder: "Email",
                supportingText: "",
                errorText: "Required Field",
                text: $signUpVM.email,
                isValid: { signUpVM.isEmailValid }
            )
            
            TTTextField(
                placeHolder: "Phone",
                supportingText: "+38 (XXX) XXX - XX - XX",
                errorText: "Required Field",
                text: $signUpVM.phone,
                isValid: { signUpVM.isPhoneValid }
            )
        }
    }
    
    private func selectPositions() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("Select your position")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.black87)
                
                Spacer()
            }
            
            ForEach(signUpVM.positionsResponse?.positions ?? []) { position in
                HStack(spacing: 25) {
                    TTRadioButton(
                        radioButtonStyle: .mediumSecondary,
                        isButtonFilled: signUpVM.selectedPosition?.id == position.id
                    ) {
                        signUpVM.selectedPosition = position
                    }
                    
                    Text(position.name)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black87)
                }
            }
        }
    }
    
    private func uploadingPhotoButton() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(hasUserTappedCameraButton && signUpVM.selectedImage != nil ? "Photo is uploaded" : "Upload your photo")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(hasUserTappedCameraButton && signUpVM.selectedImage != nil ? .green : .black48)
                
                Spacer()
                
                TTButton(
                    buttonText: "Upload",
                    buttonStyle: .secondaryUnfilled) {
                        hasUserTappedCameraButton = true
                        showActionSheet = true
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(hasUserTappedCameraButton && signUpVM.selectedImage == nil ? .error : .myGray)
            )
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Choose how you want to add a photo"),
                    buttons: [
                        .default(Text("Camera"), action: {
                            if !cameraManager.permissionGranted {
                                if cameraManager.permissionDenied {
                                    showCameraPermissionAlert = true
                                } else {
                                    cameraManager.requestPermission()
                                }
                            } else {
                                imagePickerSource = .camera
                                isImagePickerPresented = true
                            }
                            print("Camera selected")
                        }),
                        .default(Text("Gallery"), action: {
                            imagePickerSource = .photoLibrary
                            isImagePickerPresented = true
                            print("Gallery selected")
                        }),
                        .cancel(Text("Cancel"))
                    ]
                )
            }
            
            if hasUserTappedCameraButton && signUpVM.selectedImage == nil {
                Text("Photo is required")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.error)
                    .padding(.leading, 16)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(
                sourceType: imagePickerSource,
                onImagePicked: { image in
                    signUpVM.uploadImage(image)
                }
            )
        }
        .alert(isPresented: $showCameraPermissionAlert) {
            Alert(
                title: Text("Camera Permission Denied"),
                message: Text("You need to enable camera access in the Settings to upload a photo."),
                primaryButton: .default(Text("Go to Settings"), action: {
                    cameraManager.openAppSettings()  // Open settings to enable camera permission
                }),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}


struct ResultPage: View {
    let resultImage: ImageResource
    let resultText: String
    let buttonText: String
    @EnvironmentObject var router: NavigationManager

    var body: some View {
        VStack(spacing: 24) {
            Image(resultImage)
                .resizable()
                .frame(width: 200, height: 200)
            
            Text(resultText)
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black87)
            
            TTButton(
                buttonText: buttonText,
                buttonStyle: .primary,
                action: {
                    router.navigateBack()
                }
            )
        }
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    MainTabView(mainTabVM: MainTabViewModel())
        .environmentObject(CameraManager())
}
