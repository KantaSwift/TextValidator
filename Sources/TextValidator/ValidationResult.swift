import Foundation

public enum ValidationResult: Comparable, Equatable {
    case valid
    case inValid(ValidationRule)

    public static func < (lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        if case let .inValid(lhsError) = lhs,
           case let .inValid(rhsError) = rhs {
            return lhsError.rawValue < rhsError.rawValue
        }
        return true
    }
}

public extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .inValid:
            return false
        }
    }
}
