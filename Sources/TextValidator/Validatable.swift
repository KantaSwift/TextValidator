import Foundation

protocol Validatable {
    var target: String { get }
    func validate(target: String) -> ValidationResult
}

