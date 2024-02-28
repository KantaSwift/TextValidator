import Foundation

struct CompositeValidator: Validatable {
    private var validators: [Validatable]
    let target: String

    init(
        target: String,
        validators: [Validatable]
    ) {
        self.target = target
        self.validators = validators
    }

    func validate(target: String) -> ValidationResult {
        for validator in validators {
            let result = validator.validate(target: target)
            if case .inValid = result {
                return result
            }
        }
        return .valid
    }
}
