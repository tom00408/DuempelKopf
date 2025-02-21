import SwiftUI

struct NewListFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    @State private var info = ""
    @State private var playerNames: [String] = []
    @State private var newPlayerName: String = ""
    
    @State private var nurMinus = true
    @State private var maxDoppelBock = true
    @State private var mitBockStarten = false
    @State private var einsatz = ""
    
    
    @State private var OGs: [String] = ["Emil", "Erik", "Nils", "Tom", "Freddy"]
    @State private var BPs: [String] = ["Robin","Joshi","Emil","Tom"]
    private var isFormValid: Bool {
        name.count > 2 &&
        playerNames.count >= 4
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Infos") {
                    TextField("Name", text: $name)
                    TextField("Info", text: $info)
                }
                
                Section("Einstellungen") {
                    Toggle(isOn: $nurMinus) {
                        Text("Nur Minus")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    Toggle(isOn: $maxDoppelBock) {
                        Text("maximal DoppelBock")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    Toggle(isOn: $mitBockStarten) {
                        Text("mit Bock starten")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    TextField("Einsatz", text: $einsatz)
                    
                }

                
                if !playerNames.isEmpty{
                    Section(header: Text("Spieler")) {
                        
                        ForEach(playerNames, id: \.self) { name in
                            Text(name)
                                .font(
                                    .system(
                                        size: 20,
                                        weight: .bold,
                                        design: .serif
                                    )
                                )
                        }
                        .onDelete(perform: deleteName)
                        
                    }
                }
                Section(header: Text("Spieler hinzufügen")) {
                    HStack {
                        TextField("Neuer Name", text: $newPlayerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            if !newPlayerName.isEmpty {
                                playerNames.append(newPlayerName)
                                newPlayerName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                    }
                }
                if !OGs.isEmpty{
                    Section(header: Text("Wiederkehrende Spieler")) {
                        ForEach(OGs, id: \.self){ og in
                            HStack {
                                Text(og)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                                Button(action: {
                                    playerNames.append(og)
                                    OGs.removeAll { $0 == og }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
                if !BPs.isEmpty{
                    Section(header: Text("BP")) {
                        ForEach(BPs, id: \.self){ bp in
                            HStack {
                                Text(bp)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                                Button(action: {
                                    playerNames.append(bp)
                                    BPs.removeAll { $0 == bp }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
                
                
                Section{
                    Button {
                        // Aktion hier einfügen
                        createList()
                        dismiss()
                    }
                    label: {
                        HStack {
                            Spacer()
                            Text("Liste erstellen")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                    .opacity(isFormValid ? 1 : 0.5)
                    .disabled(!isFormValid)
                    .padding(.horizontal)
                }.listRowBackground(Color.clear)
            }
            .navigationTitle("Neue Liste erstellen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                
                /*ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        print("Gespeicherte Spieler: \(playerNames)")
                        dismiss()
                    }
                }*/
            }
        }
    }
    
    // Funktion zum Löschen eines Namens aus der Liste
    private func deleteName(at offsets: IndexSet) {
        playerNames.remove(atOffsets: offsets)
    }
    
    func createList() {
        let list = List(
            name: name,
            players: playerNames,
            info: info,
            nurMinus: nurMinus,
            maxDoppelBock: maxDoppelBock,
            mitBockStarten: mitBockStarten,
            einsatz: parseToDouble(einsatz)
        )
        //print(list.einsatz)
        
        context.insert(list)
    }
    func parseToDouble(_ input: String) -> Double? {
        let normalized = input.replacingOccurrences(of: ",", with: ".") // Komma durch Punkt ersetzen
        return Double(normalized) // Versuchen, den String in Double zu konvertieren
    }

    
}

#Preview {
    NewListFormView()
}
