//
//  SingleListView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 19.02.25.
//

import SwiftUI

struct SingleListView: View {
    
    @StateObject var viewModel =  SingleListViewModel()
    
    let list: List
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showDeleteAlert = false
    @State private var showSpielHinzufügen = false
    
    var body: some View {
        VStack {
            
            Text(list.name)
                .font(.system(size: 48, weight: .bold, design: .serif))
            
            HStack{
                if list.maxDoppelBock{
                    ListenFeatureView("Max DoppelBock")
                }
                if list.nurMinus{
                    ListenFeatureView("Nur Minus")
                }
            }
            Text(list.info)
                .font(.system(size: 24, weight: .light, design: .serif))
            
            /*
             SPIEL HINZUFÜGEN
             */
            Button {
                // Aktion hier einfügen
                showSpielHinzufügen.toggle()
            }
            label: {
                HStack {
                    Spacer()
                    Text("Spiel hinzufügen")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "document.badge.plus.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            
            /*
             TABELLE / STANDINGS
             */
            
            
            Spacer()
            // LISTE LÖSCHEN
            
            Button {
                // Alert anzeigen
                showDeleteAlert = true
            } label: {
                HStack {
                    Spacer()
                    Text("Liste löschen")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            .alert("Liste löschen", isPresented: $showDeleteAlert) {
                Button("Abbrechen", role: .cancel) {}
                Button("Löschen", role: .destructive) {
                    deleteList()
                }
            } message: {
                Text("Bist du sicher, dass du diese Liste löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.")
            }
        }.sheet(isPresented: $showSpielHinzufügen) {
            SpielHinzufuegenView(list: list)
        }
    }
    
    // Funktion zum Löschen der Liste
    private func deleteList() {
        context.delete(list)
        do {
            try context.save()
        } catch {
            print("Fehler beim Löschen der Liste: \(error)")
        }
        dismiss()
    }
}

#Preview {
    SingleListView(list: List.sample)
}
