import Foundation

public enum ValidationRule: LocalizedError, Equatable {
    case empty
    case strongPassword
    case length(to: Int, from: Int? = nil)
    case email

    var rawValue: Int {
        switch self {
        case .empty:
            0
        case .strongPassword:
            1
        case .length:
            0
        case .email:
            1
        }
    }
}

public extension ValidationRule {
    var errorDescription: String? {
        switch self {
        case .empty:
            return "入力されていない欄があります"
        case .strongPassword:
            return "パスワードは英数字、小文字、大文字を含めた8文字以上にしてください"
        case let .length(to, from):
            if let from = from, from > 0 {
                return "\(from)文字以上\(to)文字以内で入力してください"
            } else {
                return "\(to)文字以内で入力してください"
            }
        case .email:
            return "メールアドレスを入力してください"
        }
    }
}
