import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TodoListRouter.createModule()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
