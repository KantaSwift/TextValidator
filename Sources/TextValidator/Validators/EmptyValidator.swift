import Foundation

struct EmptyValidator: Validatable {
    let target: String

    init(target: String) {
        self.target = target
    }

    func validate(target: String) -> ValidationResult {
        return target.isEmpty ? .inValid(.empty) : .valid
    }
}
