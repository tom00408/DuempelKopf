import SwiftUI

struct MultiSelectionListView: View {
    
    @Binding var selectedItems: [String]
    let options = ["Charlie", "Fuchs", "Dulle", "Herzdurchlauf", "Doppelkopf", "Solo"]

    var body: some View {
        VStack {
            MultiSelectDropdown(title: "Optionen wählen", options: options, selectedItems: $selectedItems)
            
            // Anzeige der gewählten Elemente
            if !selectedItems.isEmpty {
                ForEach(selectedItems , id: \.self) { item in
                    HStack {
                        Text(item)
                        Spacer()
                        Button(action: {
                            if let index = selectedItems.firstIndex(of: item) {
                                selectedItems.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .frame(width: 150)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                //.frame(height: 200) // Höhe der Liste begrenzen
            }
        }
        .padding()
    }
}

#Preview {
//    MultiSelectionListView()
}
