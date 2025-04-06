import SwiftUI

// MARK: - AddTaskView
struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority: TaskPriority = .medium // Default Priority

    let colors: [Color] = [.cyan, .teal, .indigo, .mint, .brown, .gray, .yellow]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    VStack(spacing: 15) {
                        TextField("Enter Task Title", text: $title)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .shadow(radius: 2)
                        
                        TextField("Enter Description", text: $description)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .shadow(radius: 2)
                        
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .shadow(radius: 2)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Select Priority").font(.headline)
                            Picker("Priority", selection: $priority) {
                                ForEach(TaskPriority.allCases, id: \.self) { priority in
                                    Text(priority.rawValue.capitalized).tag(priority)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(radius: 2)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        let newTask = Task(title: title, description: description, dueDate: dueDate, priority: priority)
                        viewModel.addTask(newTask)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save Task")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("📝 Add Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}
