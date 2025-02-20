import SwiftUI

struct SingleSelectDropdown: View {
    
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    let partei : Partei
    
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
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .padding()
            .frame(width: 150) // Breite der DropDowns
            .background(partei == .re ? Color.Re : Color.Kontra)
            .cornerRadius(8)
        }
    }
}
