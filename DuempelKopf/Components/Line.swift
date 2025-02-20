//
//  Line.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Rectangle()
            .frame(width: 1000, height: 1)
    }
}
struct VLine: View {
    
    let h : CGFloat
    let w : CGFloat
    init(_ h : CGFloat, _ w: CGFloat = 1){
        self.h = h
        self.w = w
    }
    
    var body: some View {
        Rectangle()
            .frame(width: w, height: h)
    }
}


#Preview {
    Line()
}
