//
//  SpielHinzufügenView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 19.02.25.
//

import SwiftUI

struct SpielHinzufuegenView: View {
    
    var list: List
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    private var isSpielValid: Bool {
        let playingTeams = teams.values.filter { $0 != .notPlaying }
        
        let reCount = playingTeams.filter { $0 == .re }.count
        let kontraCount = playingTeams.filter { $0 == .kontra }.count
        
        return playingTeams.count == 4 &&
               (reCount == 1 || reCount == 2) &&
               (kontraCount == 2 || kontraCount == 3) &&
                (reAugen != nil && kontraAugen != nil) &&
                (0 <= reAugen ?? -1 && reAugen ?? 251 <=  240)
        
    }

    
    @State private var selectedReOption : String = "-"
    @State private var selectedKontraOption : String = "-"
    
    @State private var reSonderpunkte : [String] = []
    @State private var kontraSonderpunkte : [String] = []
    
    let reOptions = ["-","Re", "keine 90", "keine 60", "keine 30", "Schwarz"]
    let kontraOptions = ["-","Kontra", "keine 90", "keine 60", "keine 30", "Schwarz"]
    
    @State var teams: [String: Partei] = [:]
    
    @State private var reAugen: Int? = nil
    @State private var kontraAugen: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Line()
                VStack {
                    ForEach(Array(teams.keys).chunked(into: 3), id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { key in
                                if let binding = bindingForKey(key) { // Sichere Binding-Referenz
                                    PlayerParteiView(key: key, partei: binding)
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Line()
                /*
                 Ansagen
                 */
                HStack {
                    /*
                     Re Überschrift
                     */
                    HStack {
                        Text("Re-Partei")
                        Image(systemName: "suit.club")
                    }
                    .frame(maxWidth: .infinity) // Nimmt die gesamte verfügbare Breite
                    .padding()
                    .background(Color(hex: "#1A1A1D")) // Schwarz für Re
                    .foregroundColor(.white) // Kontrastfarbe für bessere Lesbarkeit
                    
                    /*
                     Kontra Überschrift
                     */
                    HStack {
                        Text("Kontra-Partei")
                        Image(systemName: "suit.diamond")
                    }
                    .frame(maxWidth: .infinity) // Nimmt die gesamte verfügbare Breite
                    .padding()
                    .background(Color(hex: "#D72638")) // Rot für Kontra
                    .foregroundColor(.white) // Kontrastfarbe
                }
                .frame(maxWidth: .infinity) // Stellt sicher, dass der gesamte HStack breit bleibt

                
                HStack{
                    Spacer()
                    SingleSelectDropdown(
                        title: "",
                        options: reOptions,
                        selectedOption: $selectedReOption
                    )
                    Text("Ansagen")
                        .font(.system(size: 16,weight: .bold, design: .serif))
                    SingleSelectDropdown(
                        title: "",
                        options: kontraOptions,
                        selectedOption: $selectedKontraOption
                    )
                    Spacer()
                    
                }
                
                HStack{
                    Spacer()
                    SingleNumberInput(
                        title: "Re",
                        value: $reAugen,
                        linkedValue: $kontraAugen,
                        total: 240
                    )
                    Text("  Augen  ")
                        .font(.system(size: 16,weight: .bold, design: .serif))
                    
                    SingleNumberInput(
                        title: "Kontra",
                        value: $kontraAugen,
                        linkedValue: $reAugen,
                        total: 240
                    )
                    Spacer()
                }
                HStack(alignment: .top){
                    MultiSelectionListView(selectedItems: $reSonderpunkte)
                    MultiSelectionListView(selectedItems: $kontraSonderpunkte)
                }
    
                
                
                Spacer()
            }
            .navigationTitle("Spiel hinzufügen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Speichern") {
                        print(teams)
                        updateListe()
                        dismiss()
                    }.disabled(!isSpielValid)
                }
            }
            .onAppear {
                //Initialisiere Teams
                for player in list.players {
                    teams[player.name] = .notPlaying
                }
            }
        }
    }
    
    
    // Aktualisiert die Liste in SwiftData
    private func updateListe() {
        
        list.name.append(" (\(Date()))")
        
        do {
            try context.save()
        } catch {
            print("Liste konnte nicht gespeichert werden: \(error)")
        }
    }
    
    private func bindingForKey(_ key: String) -> Binding<Partei>? {
        guard teams.keys.contains(key) else { return nil }
        return Binding(
            get: { teams[key, default: .notPlaying] },
            set: { teams[key] = $0 }
        )
    }

    
}

#Preview {
    SpielHinzufuegenView(list: List.sample)
}


// Enum für Partei
enum Partei: String, Codable, CaseIterable, Identifiable {
    case re, kontra, notPlaying
    
    var id: Self { self }
    
    var descr: String {
        switch self {
        case .re: "Re"
        case .kontra: "Kontra"
        case .notPlaying: "---"
        }
    }
}
