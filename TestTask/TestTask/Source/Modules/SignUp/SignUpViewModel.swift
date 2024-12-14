//
//  SignUpViewModel.swift
//  TestTask
//
//  Created by Temur Chitashvili on 13.12.24.
//

import Foundation
import NetworkingPackage
import UIKit

final class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var positionsResponse: PositionsResponse?
    @Published var selectedPosition: Position?
    @Published var selectedImage: UIImage? = nil

    
    var isNameValid: Bool {
        !name.isEmpty
    }
    
    var isEmailValid: Bool {
        // Simple email regex to check format (e.g., "example@domain.com")
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var isPhoneValid: Bool {
        // Validates Ukrainian phone numbers (e.g., +380XXXXXXXXX)
        let phoneRegex = "^\\+38\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    
    var isFormValid: Bool {
        isNameValid && isEmailValid && isPhoneValid && selectedPosition != nil && selectedImage != nil
    }
    
    init() {
        getPositions()
    }
    
    private func getPositions() {
        NetworkService.shared.sendRequest(endPoint: EndPointsManager.getPositions) { [weak self] (result: Result<PositionsResponse, NetworkError>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let success):
                    self?.positionsResponse = success
                case .failure(let failure):
                    print("Can't Get Positions Response \(failure)")
                }
            }
        }
    }
    
    func uploadImage(_ image: UIImage) {
        // You can implement your upload logic here
        self.selectedImage = image
        print("Image selected: \(image)")
    }
    
    func submitSignUpForm(completion: @escaping (Bool, String) -> Void) {
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8),
              let positionId = selectedPosition?.id else {
            completion(false, "Please fill out all fields and upload an image.")
            return
        }

        let boundary = UUID().uuidString
        let url = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1/users")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(AuthManager.shared.authResponse?.token, forHTTPHeaderField: "Token")

        // Build multipart form-data body
        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n")
        body.append("\(name)\r\n")

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"email\"\r\n\r\n")
        body.append("\(email)\r\n")

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"phone\"\r\n\r\n")
        body.append("\(phone)\r\n")

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"position_id\"\r\n\r\n")
        body.append("\(positionId)\r\n")

        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\r\n")
        body.append("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.append("\r\n")

        body.append("--\(boundary)--\r\n")
        request.httpBody = body

        // Perform network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, "Request failed: \(error.localizedDescription)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      let data = data else {
                    completion(false, "Invalid server response.")
                    return
                }

                do {
                    // Decode response based on status code
                    if httpResponse.statusCode == 201 {
                        let successResponse = try JSONDecoder().decode(SuccessResponse.self, from: data)
                        completion(true, successResponse.message)
                    } else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(false, errorResponse.message)
                    }
                } catch {
                    completion(false, "Failed to parse response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
