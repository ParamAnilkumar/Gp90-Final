import SwiftUI

struct NavigationTabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Tasks")
                }
            AddTaskView(viewModel: TaskViewModel())
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add Task")
                }
        }
    }
}

