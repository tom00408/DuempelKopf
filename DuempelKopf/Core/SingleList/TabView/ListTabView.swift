//
//  ListTabView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import SwiftUI

struct ListTabView: View {
    
    let list : List
    
    init(_ list: List){
        self.list = list
    }
    
    var body: some View {
        TabView {
            ListTableView(list)
            ListGraphView(list)
            ListPotView(list)
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

#Preview {
    ListTabView(List.preview)
}
