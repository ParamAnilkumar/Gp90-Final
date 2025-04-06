import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [
        Task(title: "Complete Xcode Project", description: "Implement all views and navigation", dueDate: Date(), priority: .high),
        Task(title: "Buy Groceries", description: "Get milk, eggs, and bread", dueDate: Date().addingTimeInterval(86400), priority: .medium),
        Task(title: "Finish Assignment", description: "Submit project before deadline", dueDate: Date().addingTimeInterval(172800), priority: .low)
    ]
    
    func addTask(_ task: Task) {
        tasks.append(task)
        sortTasks()
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            sortTasks()
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func sortTasks() {
        tasks.sort { (task1, task2) -> Bool in
            if task1.priority == task2.priority {
                return task1.dueDate < task2.dueDate
            }
            return task1.priority.rawValue < task2.priority.rawValue
        }
    }
}
