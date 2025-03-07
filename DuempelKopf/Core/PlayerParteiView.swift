//
//  PlayerParteiView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import SwiftUI

struct PlayerParteiView: View {
    
    var key: String
    @Binding var partei : Partei
    
    private var img: String? {
        switch partei {
        case .re:
            return "suit.club"
        case .notPlaying:
            return nil
        case .kontra:
            return "suit.diamond"
        case .beideVerlieren:
            return nil
        }
        
    }
    
    private var color: Color {
        switch partei {
        case .re:
            return Color(hex: "#1A1A1D")
        case .notPlaying:
            return .gray
        case .kontra:
            return Color(hex: "#D72638")
        case .beideVerlieren:
            return .purple
        }
    }
    
    
    
    var body: some View {
        Button{
            switch partei {
                case .re:
                    partei = .kontra
                case .kontra:
                    partei = .notPlaying
                case .notPlaying:
                    partei = .re
            case .beideVerlieren:
                partei = .re
            }
        }label:{
            HStack {
                Text("\(key)")
                    .padding(.horizontal, 4)
                    .font(.system(size: 18, weight: .light, design: .serif))
                if let img{
                    Image(systemName: img)
                }
            }
            .padding()
            .background(color)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.primary, lineWidth: 1)
            )
            .accentColor(partei == .re ? .white : .black)
        }
    }
}

#Preview {
    //PlayerParteiView()
}
