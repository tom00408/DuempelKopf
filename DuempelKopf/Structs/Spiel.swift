//
//  Spiel.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import Foundation



struct Spiel: Codable, Identifiable {
    var id :String
    var teams : [String : Partei]
    var reAugen : Int
    var kontraAugen : Int
    var selectedReOption : String
    var selectedKontraOption : String
    var reSonderpunkte : [String]
    var kontraSonderpunkte :[String]
}

