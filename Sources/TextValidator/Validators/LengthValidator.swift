import Foundation

struct LengthValidator: Validatable {
    let target: String
    let to: Int
    let from: Int?

    init(target: String, to: Int, from: Int? = nil) {
        self.target = target
        self.to = to
        self.from = from
    }

    func validate(target: String) -> ValidationResult {
        if let from = from {
            guard target.count >= from && target.count <= to else {
                return .inValid(.length(to: to, from: from))
            }
        } else {
            guard target.count <= to else {
                return .inValid(.length(to: to, from: 0))
            }
        }
        return .valid
    }
}
