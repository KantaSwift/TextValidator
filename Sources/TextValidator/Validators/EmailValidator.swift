import Foundation

struct EmailValidator: Validatable {
    let target: String

    init(target: String) {
        self.target = target
    }

    func validate(target: String) -> ValidationResult {
        guard target.isEmail else {
            return .inValid(.email)
        }
        return .valid
    }
}
