import Foundation

struct Todo: Decodable {
    var id: Int
    var todo: String
    var completed: Bool
}

struct Todos: Decodable {
    var todos: [Todo]
}
