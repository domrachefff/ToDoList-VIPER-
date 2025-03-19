import SwiftUI

protocol TodoListPresenterProtocol: ObservableObject {
    var searchText: String { get set }
    func addTodo(title: String, description: String, date: Date)
    func toggleTaskStatus(_ item: Item)
    func deleteItems(at offsets: IndexSet, todos: FetchedResults<Item>)
    func updateTodo(task: Item, title: String, description: String, date: Date)
    func updateTodosFromAPI()
    func updateSearchPredicate(todos: FetchedResults<Item>)
}

final class TodoListPresenter: TodoListPresenterProtocol {
    
    @Published var searchText: String = ""
    private let interactor: TodoListInteractorProtocol
    
    init(interactor: TodoListInteractorProtocol) {
        self.interactor = interactor
    }
    
    func addTodo(title: String, description: String, date: Date) {
        interactor.addTodo(title: title, description: description, date: date)
    }
    
    func toggleTaskStatus(_ item: Item) {
        interactor.toggleTaskStatus(item)
    }
    
    func deleteItems(at offsets: IndexSet, todos: FetchedResults<Item>) {
        interactor.deleteItems(at: offsets, todos: todos)
    }
    
    func updateTodo(task: Item, title: String, description: String, date: Date) {
        interactor.updateTodo(task: task, title: title, description: description, date: date)
    }
    
    func updateTodosFromAPI() {
        interactor.updateTodosFromAPI()
    }
    
    func updateSearchPredicate(todos: FetchedResults<Item>) {
        todos.nsPredicate = interactor.updatePredicate(searchText: searchText)
    }
    
}

