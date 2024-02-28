import Foundation

extension String {
    var strongPassword: Bool {
        let validate = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", validate).evaluate(with: self)
    }
}
