import SwiftUI
import CoreData

protocol TodoListInteractorProtocol {
    func addTodo(title: String, description: String, date: Date)
    func toggleTaskStatus(_ item: Item)
    func deleteItems(at offsets: IndexSet, todos: FetchedResults<Item>)
    func updateTodo(task: Item, title: String, description: String, date: Date)
    func updateTodosFromAPI()
    func updatePredicate(searchText: String) -> NSPredicate?
}

final class TodoListInteractor: TodoListInteractorProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTodo(title: String, description: String, date: Date) {
        context.perform {
            let newTask = Item(context: self.context)
            newTask.id = UUID()
            newTask.title = title
            newTask.todoDescription = description
            newTask.completedDate = date
            newTask.completed = false

            self.saveContext()
        }
    }
    
    func toggleTaskStatus(_ item: Item) {
        context.perform {
            item.completed.toggle()
            self.saveContext()
        }
    }
    
    func deleteItems(at offsets: IndexSet, todos: FetchedResults<Item>) {
        context.perform {
            offsets.map { todos[$0] }.forEach(self.context.delete)
            self.saveContext()
            print("Задача удалена")
        }
    }
    
    func updateTodo(task: Item, title: String, description: String, date: Date) {
        context.perform {
            task.title = title
            task.todoDescription = description
            task.completedDate = date
            self.saveContext()
        }
    }
    
    func updatePredicate(searchText: String) -> NSPredicate? {
        if searchText.isEmpty {
            return nil
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@ OR todoDescription CONTAINS[cd] %@", searchText, searchText)
        }
    }
    
    
    func updateTodosFromAPI() {
        DispatchQueue.global(qos: .background).async {
            NetworkService.shared.fetchTodosFromAPI { result in
                switch result {
                case .success(let todos):
                    self.context.perform {
                        self.saveToCoreData(todos)
                    }
                case .failure(let error):
                    print("Ошибка загрузки данных: \(error.localizedDescription)")
                }
            }
        }
    }

    
    private func saveToCoreData(_ todos: [Todo]) {
        context.perform {
            do {
                for todo in todos {
                    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "idAPI == %d", todo.id)
                    
                    if let existingTodo = try self.context.fetch(fetchRequest).first {
                        existingTodo.title = todo.todo
                        existingTodo.completed = todo.completed
                    } else {
                        let newTodo = Item(context: self.context)
                        newTodo.idAPI = Int16(todo.id)
                        newTodo.title = todo.todo
                        newTodo.completed = todo.completed
                        newTodo.id = UUID()
                    }
                }
                
                try self.context.save()
                print("Todos успешно обновлены в Core Data")
            } catch {
                print("Ошибка сохранения в Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения в Core Data: \(error.localizedDescription)")
        }
    }
}
