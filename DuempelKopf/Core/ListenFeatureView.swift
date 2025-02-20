//
//  ListenFeatureView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 19.02.25.
//

import SwiftUI

struct ListenFeatureView: View {
    
    let text: String
    
    init(_ text: String){
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 6)
            .font(.system(size: 10, weight: .light, design: .serif))
            .background{
                RoundedRectangle(cornerRadius: 24)
                    .stroke(style: StrokeStyle(lineWidth: 1)
                    )}
    }
}

#Preview {
    ListenFeatureView("Max DoppelBock")
}
