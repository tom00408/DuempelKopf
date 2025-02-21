//
//  Array.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import Foundation

// Erweiterung für das Chunking in Gruppen von 3 Elementen
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    subscript(safe index: Int) -> Element? {
            return indices.contains(index) ? self[index] : nil
        }
}
