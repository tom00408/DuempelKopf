import SwiftUI

struct SingleSelectDropdown: View {
    
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        } label: {
            HStack {
                /*Text(title)
                    .foregroundColor(.primary)
                Spacer()*/
                Text(selectedOption)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .padding()
            .frame(width: 150) // Breite der DropDowns
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}
