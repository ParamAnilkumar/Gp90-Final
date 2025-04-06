import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var db = Firestore.firestore()

    init() {
        fetchTasks()
    }

    func fetchTasks() {
        db.collection("tasks").order(by: "dueDate").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents or error: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            self.tasks = documents.compactMap { doc in
                try? doc.data(as: Task.self)
            }
        }
    }

    func addTask(_ task: Task) {
        do {
            _ = try db.collection("tasks").addDocument(from: task)
        } catch {
            print("Error adding task: \(error)")
        }
    }

    func updateTask(_ task: Task) {
        guard let taskID = task.id else { return }
        do {
            try db.collection("tasks").document(taskID).setData(from: task)
        } catch {
            print("Error updating task: \(error)")
        }
    }

    func deleteTask(_ task: Task) {
        guard let taskID = task.id else { return }
        db.collection("tasks").document(taskID).delete { error in
            if let error = error {
                print("Error deleting task: \(error)")
            }
        }
    }

    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}
