//
//  ContentView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 18.02.25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var lists: [List]
    
    @State private var showForm = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                NavigationLink{
                    SingleListView(list: List.sample)
                }label: {
                    ListRowView(list: List.sample)
                }
                ForEach(lists) { list in
                    NavigationLink{
                        SingleListView(list: list)
                    }label:{
                        ListRowView(list: list)
                    }
                }
                Button {
                    // Aktion hier einfügen
                    showForm.toggle()
                }
                label: {
                    HStack {
                        Spacer()
                        Text("Erstelle deine erste Liste")
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
                
            }
            .background(Color(.systemGray4))
            .navigationTitle("Listen")
            .toolbar {
                NavigationLink {
                    InfoView()
                        .background(Color(.systemGray4))
                } label: {
                    Image(systemName: "info.bubble.fill")
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showForm) {
                NewListFormView()
            }
                
        }
    }
    
   
}

#Preview {
    ListView()
}
