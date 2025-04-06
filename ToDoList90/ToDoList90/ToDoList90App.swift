import SwiftUI
import Firebase

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationTabView()
        }
    }
}
