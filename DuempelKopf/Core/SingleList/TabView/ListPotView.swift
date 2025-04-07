//
//  ListPotView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import SwiftUI
import Charts

struct ListPotView: View {
    
    let list : List
    
    init(_ list : List) {
        self.list = list
    }
    
    var letzteErgebnisse: [(label: String, value: Double, color: Color)] {
        let farben: [Color] = [
            .red,
            .blue,
            .green,
            .purple,
            .orange,
            .yellow
        ] // Mehr Farben für Spieler
        var index = 0
        
        return list.block.compactMap { (key, values) in
            if key != "Punkte" && key != "Böcke", let lastValue = values.last {
                let color = farben[index % farben.count] // Zyklische Farbvergabe
                index += 1
                return (label: key, value: Double(lastValue), color: color)
            }
            return nil
        }
    }
    
    var body: some View {
        VStack {
            /*Text("\(list.name) - Letzte Ergebnisse")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            */
            ZStack{
                
                Chart(letzteErgebnisse, id: \.label) { element in
                    SectorMark(angle: .value("Wert", element.value), innerRadius: .ratio(0.5))
                        .foregroundStyle(element.color)
                        .annotation(position: .overlay) { // 🔥 Beschriftung in den Sektor setzen
                            //Text((element.value * list.einsatz!).asEuroString())
                            Text(element.label)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                }
                .frame(width: 300, height: 300)
                
                Text(list.getPott())
                    .fontWeight(.bold)
                    
            }
            // 🔥 Legende unter dem Diagramm
            VStack(alignment: .leading) {
                ForEach(letzteErgebnisse, id: \.label) { item in
                    HStack {
                        Circle()
                            .fill(item.color)
                            .frame(width: 10, height: 10)
                        Text("\(item.label): \(Int(item.value))")
                            .font(.caption)
                    }
                }
            }
            .padding(.top, 10)
            //Spacer()
        }
    }
}

#Preview {
    ListPotView(List.preview)
}
