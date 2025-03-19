import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Поиск", text: $text)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
