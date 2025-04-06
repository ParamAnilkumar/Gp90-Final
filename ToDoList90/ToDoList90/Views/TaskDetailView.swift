import SwiftUI

struct TaskDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var task: Task
    @ObservedObject var viewModel: TaskViewModel
    @State private var showingEditTask = false

    let priorityColors: [TaskPriority: Color] = [
        .high: .red, .medium: .orange, .low: .green
    ]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("TASK DETAILS").foregroundColor(.gray)) {
                    HStack {
                        Text(task.title)
                            .font(.headline)
                        Spacer()
                        Text(task.priority.rawValue.capitalized)
                            .font(.caption)
                            .padding(6)
                            .background(priorityColors[task.priority]?.opacity(0.8) ?? .gray)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                    Text(task.description)
                        .padding(.top, 2)
                    
                    HStack {
                        Text("Due Date:")
                        Spacer()
                        Text(task.dueDate, style: .date)
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    Button(action: {
                        markTaskAsCompleted()
                    }) {
                        Text(task.isCompleted ? "Task Completed" : "Complete Task")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding()
                            .background(task.isCompleted ? Color.gray : Color.green)
                            .cornerRadius(10)
                    }
                    .disabled(task.isCompleted)
                }
                
                Section {
                    Button("Delete Task", role: .destructive) {
                        viewModel.deleteTask(task)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Task Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditTask = true
                    }
                }
            }
            .sheet(isPresented: $showingEditTask) {
                EditTaskView(task: task, viewModel: viewModel)
            }
        }
    }
    
    func markTaskAsCompleted() {
        var updatedTask = task
        updatedTask.isCompleted = true
        viewModel.updateTask(updatedTask)
        presentationMode.wrappedValue.dismiss()
    }
}
