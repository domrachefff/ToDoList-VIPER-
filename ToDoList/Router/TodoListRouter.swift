import SwiftUI

protocol TodoListRouterProtocol {
    static func createModule() -> ContentView
    static func presentTaskDetailView(from view: ContentView, presenter: TodoListPresenter, task: Item?)
}

final class TodoListRouter: TodoListRouterProtocol {
    static func createModule() -> ContentView {
        let interactor = TodoListInteractor(context: PersistenceController.shared.container.viewContext)
        let presenter = TodoListPresenter(interactor: interactor)
        return ContentView(presenter: presenter)
    }
    
    static func presentTaskDetailView(from view: ContentView, presenter: TodoListPresenter, task: Item?) {
        let taskDetailView = TaskDetailView(presenter: presenter, task: task)
        let sheet = UIHostingController(rootView: taskDetailView)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(sheet, animated: true, completion: nil)
        }
    }
}
