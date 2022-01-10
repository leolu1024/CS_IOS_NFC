import Foundation

enum QuickAction: String {
    case reader
}

final class QuickActionService: ObservableObject {
    @Published var action: QuickAction?

    init(initialValue: QuickAction? = nil) {
        action = initialValue
    }
}
