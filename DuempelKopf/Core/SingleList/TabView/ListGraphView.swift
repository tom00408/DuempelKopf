//
//  ListGraphView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import SwiftUI
import Charts

struct ListGraphView: View {
    
    let list : List
    
    init(_ list : List) {
        self.list = list
    }
    
    
    
    var body: some View {
            Chart {
                ForEach(list.block.keys.sorted(), id: \.self) { key in
                    if key != "Böcke" && key != "Punkte" ,let liste = list.block[key] {
                        ForEach(Array(liste.enumerated()), id: \.offset) { index, wert in
                            LineMark(
                                x: .value("Runde", index + 1),
                                y: .value("Punkte", wert)
                            )
                        }
                        .foregroundStyle(by: .value("Spieler", key))
                    }
                }
            }
            .chartXScale(
                domain: 1...(list.block["Punkte"]?.count ?? 5)
            )
            .padding()
            .aspectRatio(1, contentMode: .fit)
        
    }
}

#Preview {
    ListGraphView(List.preview)
}
