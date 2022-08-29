# PLAlert

Highly customizable and interactive transtionable alert controller with simple usage. 

## Installation

#### Cocoapods
```ruby
pod 'PLAlert'
```
#### Swift Package Manager

1. File > Swift Packages > Add Package Dependency
2. Add `https://github.com/baris-cakmak/PLAlert.git`

_OR_

Update `dependencies` in `Package.swift`
```swift
dependencies: [
    .package(url: "https://github.com/baris-cakmak/PLAlert.git", .upToNextMajor(from: "1.0.0"))
]
```
## Screenshots
<p align="center">
<img src="https://user-images.githubusercontent.com/96867747/187092041-6d9a721e-3441-42b4-86f6-9151f129a2ad.gif" width="31%">
<img src="https://user-images.githubusercontent.com/96867747/187092420-005c0a90-a808-4cbd-87cd-d29295d1396e.gif" width="31%"> 
<img src="https://user-images.githubusercontent.com/96867747/187092910-b5953e31-056c-40ad-a570-8b4b7650712f.gif" width="31%">
</p>

## Usage
```swift
import UIKit
import PLAlert

final class ViewController: UIViewController, AlertPresentable {
    // MARK: - Minimum Usaget with AlertPresentable Protocol
    func someFunc() {
        // this is the minimum usage of the current api.
        showAlert(type: PLAlertController.self, message: "message")
    }
    // MARK: - Minimum Usage with AlertPresentable Protocol
    func someFunc() {
        // default view properties with custom parameters
        showAlert(type: PLAlertController.self, title: "custom", message: "custom", buttonText: "custom", animationConfiguration: .init(animationStartPosition: .bottomRight, animationEndPosition: .bottomLeft, animationPresentDuration: 3, animationDismissalDuration: 2, dimmingViewAlpha: 0.7))
    }
    // MARK: - Usage with Inherited PLAlertController
    func someFunc() {
        // Use Inheritance to Achieve this. Check Example App
        showAlert(type: InheritedAlertController.self, message: "message")
    }
    // MARK: - Direct usage by calling the Controller - You do not need AlertPresentable Protocol
    func someFunc() {
        let alertController = PLAlertController(title: "title", text: "message", buttonText: "Cancel", animationConfiguration: .init(animationStartPosition: .top, animationEndPosition: .bottomRight))
        // some property injection
        alertController.messageBackgroundColor = .red
        alertController.containerWidthRatio = 0.6
        // some property injection
        present(alertController, animated: true)
    }
}
```
## Authors
* [Barış Çakmak](https://twitter.com/peace_lighter)

## License
PLAlert is available under the MIT license. See the LICENSE file for more info.
