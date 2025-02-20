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
    var block : [String : [Int]]
    var nurMinus : Bool
    var maxDoppelBock: Bool
    var einsatz : Double?
    
    init(name: String, players: [String], info: String, nurMinus: Bool = true, maxDoppelBock: Bool = true, mitBockStarten : Bool = false, einsatz: Double? = nil) {
        
        self.id = UUID().uuidString
        self.name = name
        self.info = info
        self.players = []
        self.block = [
            "Punkte" : [],
            "Böcke" :[mitBockStarten ? 1 : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        ]
        self.nurMinus = nurMinus
        self.maxDoppelBock = maxDoppelBock
        self.einsatz = einsatz
        
        for playerName in players{
            self.players.append(Player(playerName))
            self.block[playerName] = []
        }
        
        
    }
    
    
    static var sample = List(
        name: "TestListe",
        players: Player.allNames,
        info: "Die erste Testliste",
        mitBockStarten: true,
        einsatz: 0.2
        
    )
    
}
