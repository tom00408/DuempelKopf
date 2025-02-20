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
        HStack{
            Spacer()
            VStack{
                Text(list.name)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                Text(list.info)
                    .italic()       
            }
            Spacer()
            VStack{
                ForEach (list.players){player in
                    Text(player.name)
                        
                }
            }
            Spacer()
        }
        .padding(8)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(24)
    }
}

#Preview {
    ListRowView(list: List.sample)
}
