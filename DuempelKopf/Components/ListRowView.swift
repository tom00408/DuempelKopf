//
//  ListRowView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 19.02.25.
//
import SwiftUI

struct ListRowView: View {
    
    let list: List
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(list.name)
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(.primary)
                
                Text(list.info)
                    .font(.system(size: 16, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(.secondary)
                if let e = list.einsatz {
                    if e >= 1 {
                        ListenFeatureView("\(e)€ pro Punkt")
                    }else{
                        ListenFeatureView("\(Int(e*100))ct pro Punkt")
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                ForEach(list.players) { player in
                    Text(player.name)
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemGray6))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
        )
    }
}

#Preview {
    ListRowView(list: List.sample)
}
