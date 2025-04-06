import Foundation
import FirebaseFirestoreSwift

enum TaskPriority: String, Codable, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

struct Task: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var title: String
    var description: String
    var dueDate: Date
    var priority: TaskPriority
    var isCompleted: Bool

    init(id: String? = nil, title: String, description: String, dueDate: Date, priority: TaskPriority = .medium, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.priority = priority
        self.isCompleted = isCompleted
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.dueDate == rhs.dueDate &&
               lhs.priority == rhs.priority &&
               lhs.isCompleted == rhs.isCompleted
    }
}
