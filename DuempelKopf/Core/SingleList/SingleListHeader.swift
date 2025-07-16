//
//  SingleListHeader.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 21.02.25.
//

import SwiftUI

struct SingleListHeader: View {
    
    let list : List
    init(_ list: List){
        self.list = list
    }
    var body: some View {
        Text(list.name)
            .font(.system(size: 48, weight: .bold, design: .serif))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .truncationMode(.tail)
        
        
        HStack {
            if let e = list.einsatz {
                if e >= 1 {
                    ListenFeatureView("\(e)€ pro Punkt")
                }else{
                    ListenFeatureView("\(e*100)ct pro Punkt")
                }
            }
            if list.maxDoppelBock {
                ListenFeatureView("Max DoppelBock")
            }
            if list.nurMinus {
                ListenFeatureView("Nur Minus")
            }
        }
        
        Text(list.info)
            .font(.system(size: 24, weight: .light, design: .serif))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .truncationMode(.tail)
        
    }
}

#Preview {
    SingleListHeader(List.sample)
}
