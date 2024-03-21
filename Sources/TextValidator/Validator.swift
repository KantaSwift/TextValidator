import Foundation

public class Validator<Key: Hashable> {
    private var validationResults: [Key: ValidationValue] = [:]

    public init() {}

    public func add(text: String, forKey key: Key, using rules: [ValidationRule]) {
        let validators = rules.map { ValidatorFactory.createValidator(for: $0, target: text) }
        let results = validators.map { $0.validate(target: text) }

        let sortedResults = results.filter { if case .inValid = $0 { return true } else { return false } }.sorted(by: <)

        if let firstError = sortedResults.first, case let .inValid(validationType) = firstError {
            self.validationResults[key] = ValidationValue(error: validationType.errorDescription, isValid: false)
        } else {
            self.validationResults[key] = ValidationValue(error: nil, isValid: true)
        }
    }

    @discardableResult
    public func get(forKey key: Key) -> ValidationValue {
        return validationResults[key] ?? ValidationValue(error: nil, isValid: true)
    }

    @discardableResult
    public func allValid() -> Bool {
        return validationResults.values.allSatisfy { $0.isValid }
    }

    @discardableResult
    public func someValid(for keys: [Key]) -> Bool {
        for key in keys {
            if !(validationResults[key]?.isValid ?? false) {
                return false
            }
        }
        return true
    }
}
