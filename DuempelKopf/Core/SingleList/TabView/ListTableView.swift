//
//  ListTableView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import SwiftUI

struct ListTableView: View {
    
    let list : List
    
    init(_ list : List) {
        self.list = list
    }
    
    private var länge: CGFloat {
        if let l =  list.block["Böcke"]?.count{
            return l > 600 ? CGFloat(l * 10) : 600
        }else{
            return 600
        }
    }
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var slim: Bool {
        screenWidth < 450
    }
    
    private var fontSize : CGFloat {
        slim ? 16 : 32
    }
    
    
    var body: some View {
        ScrollView{
            HStack(alignment: .top){
                ForEach(list.block.keys.sorted(), id: \.self){ key in
                    if key != "Böcke" && key != "Punkte" {
                        VLine(länge)
                        Spacer()
                        VStack{
                            Text(key.prefix(slim ? 4: 10))
                                .fontWeight(.bold)
                            if let werte = list.block[key]{
                                ForEach(werte, id: \.self){ wert in
                                    Text("\(wert)")
                                        .font(.system(size: fontSize))
                                    
                                }
                            }
                        }
                        Spacer()
                        
                    }
                }
                
                VLine(länge,2)
                Spacer()
                //Punkte
                VStack{
                    Text("P")
                        .fontWeight(.bold)
                    if let werte = list.block["Punkte"]{
                        ForEach(werte, id: \.self){ wert in
                            
                            Text("\(wert)")
                                .font(.system(size: fontSize))
                            
                            
                        }
                    }
                }
                Spacer()
                VLine(länge)
                // BÖcke
                VStack{
                    Text("  ")
                    if let werte = list.block["Böcke"]{
                        ForEach(werte, id: \.self){ wert in
                            Text(wert == 0 ? " " : wert == 1 ? "🐐" : wert == 2 ? "🐐🐐" : "\(wert)🐐")
                                .font(.system(size: fontSize))
                        }
                    }
                }
                
            }
            Spacer()
            
        }.padding()
            .background{
                RoundedRectangle(cornerRadius: 4)
                    .stroke(style: StrokeStyle(lineWidth: 1)
                    )
                .padding(8)}
    }
}

#Preview {
    ListTableView(List.preview)
}
