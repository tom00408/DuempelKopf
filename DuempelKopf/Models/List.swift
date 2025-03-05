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
    
    init(name: String, players: [String], info: String, nurMinus: Bool = true, maxDoppelBock: Bool = true, mitBockStarten : Bool = false, einsatz: Double? = nil, block : [String : [Int]]? = nil) {
        
        self.id = UUID().uuidString
        self.name = name
        self.info = info
        self.players = []
        self.nurMinus = nurMinus
        self.maxDoppelBock = maxDoppelBock
        self.einsatz = einsatz
        
        if block == nil{
            self.block = [
                "Punkte" : [],
                //"Punkte" : [Int.random(in: 1...10), Int.random(in: -10...10)],
                "Böcke" :[mitBockStarten ? 1 :0]
            ]
            
            
            for playerName in players{
                self.players.append(Player(playerName))
                self.block[playerName] = []
                //self.block[playerName] = [Int.random(in: 1...10), Int.random(in: -10...10)]
            }
        }else{
            self.block = block!
        }
        
        
        
            
        
        
        
    }
    
    
    static var sample = List(
        name: "TestListe",
        players: Player.allNames,
        info: "Die erste Testliste",
        nurMinus: false,
        mitBockStarten: true,
        einsatz: 0.2
    )
    
    
    static var block = [
        "Robin": [0, -4],
        "Joshi": [0, -4],
        "Magda": [-6, -6],
        "Tom" : [-6, -6],
        "Punkte" : [6,4],
        "Böcke" : [0,0,1,1,1,1]
    ]
    
    static var preview = List(name: "Preview Liste", players: [], info: "Fürs Canva",
                              einsatz: 0.2,
                              block: block)
    
}
