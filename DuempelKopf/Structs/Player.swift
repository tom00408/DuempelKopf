//
//  Player.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 19.02.25.
//

import Foundation


struct Player: Codable, Identifiable {
    
    let id: String
    let name: String
    let score: Int
    
    
    init(_ name: String){
        self.id = UUID().uuidString
        self.name = name
        self.score = 0
    }
    
    
    static var sample1 = Player("Erik")
    static var sample2 = Player("Nils")
    static var sample3 = Player("Freddy")
    static var sample4 = Player("Emil")
    static var sample5 = Player("Tom")
    
    static var allSamples: [Player] {
        return [sample1, sample2, sample3, sample4, sample5]
    }
    
    static var allNames: [String] {
        return allSamples.map(\.self.name)
    }
}
