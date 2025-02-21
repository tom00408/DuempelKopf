//
//  Partei.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import Foundation
// Enum für Partei
enum Partei: String, Codable, CaseIterable, Identifiable {
    case re, kontra, notPlaying, beideVerlieren
    
    var id: Self { self }
    
    var descr: String {
        switch self {
        case .re: "Re"
        case .kontra: "Kontra"
        case .notPlaying: "---"
        case .beideVerlieren: "Beide verlieren"
        }
    }
}
