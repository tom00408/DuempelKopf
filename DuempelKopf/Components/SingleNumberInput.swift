import SwiftUI

struct SingleNumberInput: View {
    
    let title: String
    @Binding var value: Int?
    @Binding var linkedValue: Int?
    let total: Int
    
    var body: some View {
        VStack {
            //Text(title)
              //  .foregroundColor(.primary)
            
            TextField("Eingabe", value: $value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 150, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onChange(of: value ?? 0) { newValue in
                    adjustLinkedValue(newValue)
                }
        }
    }
    
    private func adjustLinkedValue(_ newValue: Int) {
        let remaining = total - newValue
        linkedValue = max(0, remaining) // Verhindert negative Werte
    }
}
