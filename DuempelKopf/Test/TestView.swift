//
//  TestView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 05.03.25.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        TabView {
                   ForEach(0..<5) { index in
                       Text("Seite \(index + 1)")
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                           .background(index % 2 == 0 ? Color.blue : Color.green)
                           .foregroundColor(.white)
                           .font(.largeTitle)
                   }
               }
               .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}

#Preview {
    TestView()
}
