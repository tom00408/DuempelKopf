import SwiftUI

struct MultiSelectionListView: View {
    
    @Binding var selectedItems: [String]
    let options = ["Charlie", "Fuchs", "Dulle", "Herzdurchlauf", "Doppelkopf", "Solo"]
    let partei : Partei
    var color : Color{
        return partei == .re ? Color(hex: "#1A1A1D") : Color(hex: "#D72638")
    }
    var body: some View {
        VStack {
            MultiSelectDropdown(title: "Optionen wählen", options: options, selectedItems: $selectedItems, color: color)
            
            // Anzeige der gewählten Elemente
            if !selectedItems.isEmpty {
                ForEach(selectedItems , id: \.self) { item in
                    HStack {
                        Text(item)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            if let index = selectedItems.firstIndex(of: item) {
                                selectedItems.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(partei == .re ? .red : .white)
                        }
                    }
                    .frame(width: 150)
                    .padding()
                    .background(color)
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
