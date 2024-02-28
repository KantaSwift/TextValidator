import Foundation

public class Validator {
    public var validationResult: ValidationResult = .valid
    public var errorMessage: String? = nil

    public init() {}

    public func add(text: String, validationType: [ValidationType]) {
          let validators = validationType.map { ValidatorFactory.createValidator(for: $0, target: text)}
          let results = validators.map { $0.validate(target: text) }

          let sortedResults = results.filter {
              if case .inValid = $0 { return true } else { return false }
          }.sorted(by: <)

          if let firstError = sortedResults.first, case let .inValid(validateType) = firstError {
              self.validationResult = firstError
              self.errorMessage = validateType.errorDescription
          } else {
              self.validationResult = .valid
              self.errorMessage = nil
          }
      }
}
