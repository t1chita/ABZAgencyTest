# iOS ABZ Test Assignment

This repository contains the solution for the iOS Developer Test Assignment provided by **ABZ Agency**. The app showcases modern iOS development practices, including REST API integration, form validation, offline capabilities, and dynamic UI updates, implemented based on provided mockups and API documentation.

# Demo Video

Watch the demo video showcasing the app features and functionalities [Open Link](https://drive.google.com/file/d/13jPD12Fh5BgqAuWnS69fKIfL_zEsp4b2/view?usp=sharing)

---

## Features

- **Splash Screen**: A clean and minimal introductory screen.
- **GET API Integration**: Displays a paginated list of users (6 per page) sorted by registration date (newest first).
- **POST API Integration**: Implements a registration form with validation. Successfully registered users appear in the user list.
- **Offline Handling**: Displays a dedicated offline screen when the device is disconnected from the internet.
- **Dynamic UI Updates**: Populates radio buttons dynamically using API data.

---

## Requirements

- **iOS Version**: Minimum 18.1
- **Xcode Version**: 16.2
- **Swift Version**: 5.9+

---

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/t1chita/ABZAgency
   cd iOS-ABZ-Test-Assignment
   ```

2. **Open the project in Xcode**:
   ```bash
   open TestTask.xcodeproj
   ```

3. **Run the project**:
   - Select a simulator or connect a physical device running **iOS 18.1+**.
   - Press **Cmd + R** to build and run the project.

---

## Networking Package Configuration

The app uses a custom **Networking Package** for streamlined API communication.

### 1. Endpoint Configuration
Endpoints conform to the `EndPoint` protocol, defining properties like host, path, method, headers, and parameters. Requests are automatically constructed based on these configurations.

#### Example Endpoint:
```swift
import Foundation
import NetworkingPackage

enum DemoEndPoint {
    case getUsers(page: Int, count: Int)
}

extension DemoEndPoint: EndPoint {
    var host: String { "frontend-test-assignment-api.abz.agency" }
    var scheme: String { "https" }

    var path: String {
        switch self {
        case .getUsers:
            return "/api/v1/users"
        }
    }![IMG_1713-2](https://github.com/user-attachments/assets/70bd77a1-d6c2-4469-8604-6c535aca7a61)


    var method: NetworkingPackage.RequestMethod { .get }
    var header: [String: String]? { nil }
    var body: [String: NetworkingPackage.AnyEncodable]? { nil }

    var queryParams: [String: NetworkingPackage.AnyEncodable]? {
        switch self {
        case .getUsers(let page, let count):
            return [
                "page": AnyEncodable(page),
                "count": AnyEncodable(count)
            ]
        }
    }

    var pathParams: [String: String]? { nil }
}
```

### 2. Making Network Requests
To perform a network request, use the `NetworkService` class. The shared instance handles request execution and provides callbacks with results.

#### Example Network Call:
```swift
private func getUsers(completion: @escaping (Bool) -> Void) {
    NetworkService.shared.sendRequest(endPoint: EndPointsManager.getUsers(page: page, count: 6)) { [weak self] (result: Result<UsersResponse, NetworkError>) in
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success(let success):
                self?.users.append(contentsOf: success.users)
                self?.getUsersResponse = success
                completion(true)
            case .failure(let failure):
                print("Can't Fetch Users: \(failure.customMessage)")
                if failure.customMessage == "Status Code Error" {
                    self?.isServerUsersEmpty = true
                }
                completion(false)
            }
        }
    }
}
```

---

## Code Structure

The project follows the **MVVM architecture**, ensuring separation of concerns and maintainability.

### Folder Structure:

- **Models**: Data models for API responses and validation logic.
- **Views**: UI components and layouts for each screen.
- **ViewModels**: Business logic and state management for the app.
- **Utils**: Utility files (managers, extensions) used throughout the app.

---

## API Endpoints

The app interacts with the following endpoints:

- **GET /positions**: Retrieves data for populating the radio buttons on the registration form.
- **GET /users**: Fetches a paginated list of users sorted by registration date.
- **POST /register**: Handles new user registration. Registered users appear in the user list.

For detailed API documentation, visit [OpenAPI Documentation](https://openapi_apidocs.abz.dev/frontend-test-assignment-v1).

---

## Development Notes

- **Total Time Spent**: 8 hours
- **Challenges Faced**:
  - Implementing pagination logic for dynamic user loading.
  - Ensuring robust form validation.

---

## License

This repository is for evaluation purposes as part of the ABZ Agency test assignment. The code and materials are not intended for commercial or non-commercial reuse.

---

## Collaborators

**Temuri Chitashvili - iOS Developer**

### Contact:
- [LinkedIn](https://www.linkedin.com/in/temurchitashvili/)
- [Email](mailto:t1chitashvili@gmail.com)
- [Medium](https://medium.com/@t1chitashvili)
- [X (Twitter)](https://x.com/temch1t)

