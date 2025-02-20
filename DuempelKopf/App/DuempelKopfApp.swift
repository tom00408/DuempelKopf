//
//  DuempelKopfApp.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 18.02.25.
//

import SwiftUI
import SwiftData


@main
struct DuempelKopfApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
        }
        .modelContainer(for: List.self)
    }
    
    
}
