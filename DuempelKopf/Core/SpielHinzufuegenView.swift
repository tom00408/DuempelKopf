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
    
    @State private var selectedReOption : String = ""
    
    let reOptions = ["Re", "keine 90", "keine 60", "keine 30", "Schwarz"]
    
    @State var teams: [String: Partei] = [:]
    
    var body: some View {
        NavigationView {
            VStack {
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

                /*
                 Ansagen
                 */
                HStack{
                    /*
                     Re Überschrift
                     */
                    HStack{
                        Text("Re-Partei")
                        Image(systemName: "suit.club")
                    }.padding()
                    .background(){
                        Color.green
                            .cornerRadius(24)
                    }
                    /*
                     Kontra Überschrift
                     */
                    HStack{
                        Text("Kontra-Partei")
                        Image(systemName: "suit.diamond")
                        
                    }.padding()
                        .background(){
                            Color.purple
                                
                                .cornerRadius(24)
                        }
                    
                }
                
                HStack{
                   
                    
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
                    }
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
