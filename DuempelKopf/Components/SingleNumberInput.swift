import SwiftUI

struct SingleNumberInput: View {
    
    let title: String
    @Binding var value: Int?
    @Binding var linkedValue: Int?
    let total: Int
    @FocusState private var isFocused : Bool
    let partei: Partei
    var body: some View {
        VStack {
            //Text(title)
              //  .foregroundColor(.primary)
            
            TextField("Eingabe", value: $value, formatter: NumberFormatter())
                .foregroundColor(.white)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 150, height: 50)
                .background(partei == .re ? Color.Re : Color.Kontra)
                .cornerRadius(8)
                .onChange(of: value ?? 0) { newValue in
                    adjustLinkedValue(newValue)
                }
                .focused($isFocused)
                .toolbar{
                    if isFocused{
                        ToolbarItemGroup(placement: .keyboard){
                            Spacer()
                            Button("Fertig"){
                                isFocused = false
                            }
                        }
                    }
                }
        }
    }
    
    private func adjustLinkedValue(_ newValue: Int) {
        let remaining = total - newValue
        linkedValue = max(0, remaining) // Verhindert negative Werte
    }
}

