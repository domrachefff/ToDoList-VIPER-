import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var presenter: TodoListPresenter
    @State private var title: String
    @State private var description: String
    @State private var date: Date
    
    var task: Item?
    
    init(presenter: TodoListPresenter, task: Item? = nil) {
        self.presenter = presenter
        _title = State(initialValue: task?.title ?? "")
        _description = State(initialValue: task?.todoDescription ?? "")
        _date = State(initialValue: task?.completedDate ?? Date())
        self.task = task
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $title)
                    .font(.title2)
                DatePicker("Дата", selection: $date, displayedComponents: .date)
                TextEditor(text: $description)
                    .frame(minHeight: 250, maxHeight: .infinity)
            }
            .navigationTitle(task == nil ? "Новая задача" : "Редактировать")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        if let task = task {
                            presenter.updateTodo(task: task, title: title, description: description, date: date)
                        } else {
                            presenter.addTodo(title: title, description: description, date: date)
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Назад") {
                        dismiss()
                    }
                }
            }
        }
    }
}
