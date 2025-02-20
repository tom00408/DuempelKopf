import SwiftUI
import SwiftData

class SingleListViewModel: ObservableObject {
    
    @Published var list: List
    
    init(list: List) {
        self.list = list
    }
    
    func deleteList(context: ModelContext, dismiss: DismissAction) {
        context.delete(list)
        do {
            try context.save()
        } catch {
            print("Fehler beim Löschen der Liste: \(error)")
        }
        dismiss()
    }
}
/*
 LOGIK DES SPIELS
 */

extension SingleListViewModel{
    
    func addSpiel(spiel: Spiel) -> Bool {
        // Bestimme das Gewinnerteam
        var gewinner : Partei = .notPlaying
        
        
        var punkteRe = 0
        var punkteKontra = 0
        
        var re = false
        var kontra = false
        
        /*
         Ansagen für Re
         */
        if spiel.selectedReOption != "-"{
            re = true
            switch spiel.selectedReOption {
            case "Re":
                if spiel.reAugen > 120 {
                    //punkteRe += 1
                    gewinner = .re
                }
                
            case "keine 90":
                if spiel.kontraAugen < 90 {
                    punkteRe += 1
                    gewinner = .re
                }else{
                    punkteKontra += 1
                    gewinner = .kontra
                }
            case "keine 60":
                if spiel.kontraAugen < 60 {
                    punkteRe += 2
                    gewinner = .re
                }else{
                    punkteKontra += 1
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 1
                        
                    }
                    gewinner = .kontra
                }
            case "keine 30":
                if spiel.kontraAugen < 30{
                    punkteRe += 3
                    gewinner = .re
                }else{
                    punkteKontra += 1
                    if spiel.kontraAugen >= 60{
                        punkteKontra += 1
                    }
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 1
                    }
                    gewinner = .kontra
                }
            case "Schwarz":
                if spiel.kontraAugen == 0{
                    punkteRe += 4
                    gewinner = .re
                }else{
                    punkteKontra += 1
                    
                    if spiel.kontraAugen >= 30{
                        punkteKontra += 1
                    }
                    if spiel.kontraAugen >= 60{
                        punkteKontra += 1
                    }
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 1
                    }
                    gewinner = .kontra
                }
                
            default:
                gewinner = .notPlaying
            }
            
        }
        
        
        /*
         Ansagen für Kontra
         */
        if spiel.selectedKontraOption != "-" {
            kontra = true
            switch spiel.selectedKontraOption {
            case "Kontra":
                if spiel.kontraAugen >= 120 {
                    //punkteKontra += 1
                    gewinner = .kontra
                }

            case "keine 90":
                if spiel.reAugen < 90 {
                    punkteKontra += 1
                    gewinner = .kontra
                } else {
                    punkteRe += 1
                    gewinner = .re
                }

            case "keine 60":
                if spiel.reAugen < 60 {
                    punkteKontra += 2
                    gewinner = .kontra
                } else {
                    punkteRe += 1
                    if spiel.reAugen >= 90 {
                        punkteRe += 1
                    }
                    gewinner = .re
                }

            case "keine 30":
                if spiel.reAugen < 30 {
                    punkteKontra += 3
                    gewinner = .kontra
                } else {
                    punkteRe += 1
                    if spiel.reAugen >= 60 {
                        punkteRe += 1
                    }
                    if spiel.reAugen >= 90 {
                        punkteRe += 1
                    }
                    gewinner = .re
                }

            case "Schwarz":
                if spiel.reAugen == 0 {
                    punkteKontra += 4
                    gewinner = .kontra
                } else {
                    punkteRe += 1

                    if spiel.reAugen >= 30 {
                        punkteRe += 1
                    }
                    if spiel.reAugen >= 60 {
                        punkteRe += 1
                    }
                    if spiel.reAugen >= 90 {
                        punkteRe += 1
                    }
                    gewinner = .re
                }

            default:
                gewinner = .notPlaying
            }
        }

        
        
        
        //< Punktevergabe nach Augen
        if spiel.reAugen >= 151 {
            punkteRe += 2 // "Re hat hoch gewonnen"
        } else if spiel.reAugen >= 121 {
            punkteRe += 1 // "Re hat normal gewonnen"
        } else if spiel.kontraAugen >= 151 {
            punkteKontra += 2 // "Kontra hat hoch gewonnen"
        } else if spiel.kontraAugen >= 121 {
            punkteKontra += 1 // "Kontra hat normal gewonnen"
        }
        
        //Keine 6
        if spiel.kontraAugen < 60 { punkteRe += 1 }
        if spiel.reAugen < 60 { punkteKontra += 1 }
        
        
        // Sonderpunkte für "Schneider" und "Schwarz"
        
        if spiel.kontraAugen < 30 { punkteRe += 1 } // Kontra Schneider
        if spiel.kontraAugen == 0 { punkteRe += 1 }  // Kontra Schwarz
        if spiel.reAugen < 30 { punkteKontra += 1 } // Re Schneider
        if spiel.reAugen == 0 { punkteKontra += 1 }  // Re Schwarz
        
        if gewinner == .notPlaying {return false }
        // Gegen die alten
        if gewinner == .kontra {
            punkteKontra += 1
        }
        
        //RE
        if re {
            punkteKontra *= 2
            punkteRe *= 2
        }
        if kontra {
            punkteRe *= 2
            punkteKontra *= 2
        }
        
        // Sonderpunkte aus der Liste hinzufügen
        punkteRe += spiel.reSonderpunkte.count - spiel.kontraSonderpunkte.count
        punkteKontra += spiel.kontraSonderpunkte.count - spiel.reSonderpunkte.count
        
        
        
        
        var punkte = gewinner == .re ? punkteRe : punkteKontra
        
        //BÖCKE X
        if let bockList = list.block["Böcken"],
           let punkteList = list.block["Punkten"],
           punkteList.count < bockList.count {

            let bock = bockList[punkteList.count] // Sicherer Zugriff auf den Bock-Wert

            punkte *= Int(pow(2.0, Double(bock))) // pow() gibt Double zurück → Umwandlung in Int
        }

        
        // Punktvergabe für jedes Teammitglied
        for (key, partei) in spiel.teams {
            if partei == .re {
                if gewinner == .re {
                    if !list.nurMinus{
                        list.block[key]?.append(punkte+(list.block[key]?.last ?? 0))
                    }else{
                        list.block[key]?.append((list.block[key]?.last ?? 0))
                    }
                }
                list.block[key]?.append(punkteRe)
            } else if partei == .kontra {
                list.block[key]?.append(punkteKontra)
            } else {
                list.block[key]?.append(0) // Falls Spieler keiner Partei zugeordnet ist
            }
        }
        
        return true
    }
    
}

