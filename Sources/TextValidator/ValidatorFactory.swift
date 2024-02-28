import Foundation

struct ValidatorFactory {
    static func createValidator(for type: ValidationType, target: String) -> Validatable {
        switch type {
        case .empty:
            EmptyValidator(target: target)
        case .strongPassword:
            PasswordValidator(target: target)
        case let .length(to, from):
            LengthValidator(target: target, to: to, from: from)
        case .email:
           EmailValidator(target: target)
        }
    }
}

