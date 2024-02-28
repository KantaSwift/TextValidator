import Foundation

extension String {
    var isEmail: Bool {
        let validate = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        return NSPredicate(format: "SELF MATCHES %@", validate).evaluate(with: self)
    }
}
