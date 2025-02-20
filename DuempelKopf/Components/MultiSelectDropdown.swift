import SwiftUI

struct MultiSelectDropdown: View {
    
    let title: String
    let options: [String]
    @Binding var selectedItems: [String]
    let color : Color
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedItems.append(option) // Mehrfachauswahl erlaubt
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                    }
                }
            }
        } label: {
            HStack {
                //Text("selectedItems.isEmpty ? "Auswählen..." : "\(selectedItems.count) gewählt"")
                Text("Sonderpunkte")
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .padding()
            .frame(width: 150)
            .background(color)
            .cornerRadius(8)
        }
    }
}
