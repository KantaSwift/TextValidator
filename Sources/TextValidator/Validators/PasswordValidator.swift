import Foundation

struct PasswordValidator: Validatable {
    let target: String

    init(target: String) {
        self.target = target
    }

    func validate(target: String) -> ValidationResult {
        guard target.strongPassword else {
            return .inValid(.strongPassword)
        }
        return .valid
    }
}
