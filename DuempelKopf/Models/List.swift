//
//  Liste.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 18.02.25.
//

import Foundation
import SwiftData

@Model
class List: Identifiable{
    
    var id: String
    
    var name : String
    var info : String
    var players : [Player]
    
    var nurMinus : Bool
    var maxDoppelBock: Bool
    
    init(name: String, players: [String], info: String, nurMinus: Bool = true, maxDoppelBock: Bool = true) {
        
        self.id = UUID().uuidString
        self.name = name
        self.info = info
        self.players = []
        self.nurMinus = nurMinus
        self.maxDoppelBock = maxDoppelBock
        
        for playerName in players{
            self.players.append(Player(playerName))
        }
        
        
    }
    
    
    static var sample = List(
        name: "TestListe",
        players: Player.allNames,
        info: "Die erste Testliste"
    )
}
