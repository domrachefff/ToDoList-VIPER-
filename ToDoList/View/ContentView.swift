import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.idAPI, ascending: true)],
        predicate: nil
    ) private var todos: FetchedResults<Item>
    
    @StateObject private var presenter: TodoListPresenter
    
    init(presenter: TodoListPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $presenter.searchText)
                    .onChange(of: presenter.searchText) { oldValue, newValue in
                        presenter.updateSearchPredicate(todos: todos)
                    }
                List {
                    ForEach(todos, id: \.id) { item in
                        Button(action: {
                            TodoListRouter.presentTaskDetailView(from: self, presenter: presenter, task: item)
                        }) {
                            HStack {
                                Button(action: {
                                    presenter.toggleTaskStatus(item)
                                }) {
                                    Image(systemName: item.completed ? "checkmark.circle" : "circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(item.completed ? .yellow : .gray)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                VStack(alignment: .leading) {
                                    Text(item.title ?? "")
                                        .font(.headline)
                                        .strikethrough(item.completed, color: .gray)
                                    Text(item.todoDescription ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(item.completed ? .gray : .primary)
                                        .lineLimit(2)
                                    Text(item.completedDate != nil ? DateFormatter.todoFormatter.string(from: item.completedDate!) : "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete { offsets in
                        presenter.deleteItems(at: offsets, todos: self.todos)
                    }
                }
                .refreshable {
                    presenter.updateTodosFromAPI()
                }
                .onAppear {
                    presenter.updateTodosFromAPI()
                }
                .navigationTitle("Задачи")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            TodoListRouter.presentTaskDetailView(from: self, presenter: presenter, task: nil)
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    TodoListRouter.createModule()
}

