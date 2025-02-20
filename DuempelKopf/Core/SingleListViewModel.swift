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
                    punkteKontra += 2
                    gewinner = .kontra
                }
            case "keine 60":
                if spiel.kontraAugen < 60 {
                    punkteRe += 2
                    gewinner = .re
                }else{
                    punkteKontra += 2
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 2
                        
                    }
                    gewinner = .kontra
                }
            case "keine 30":
                if spiel.kontraAugen < 30{
                    punkteRe += 3
                    gewinner = .re
                }else{
                    punkteKontra += 2
                    if spiel.kontraAugen >= 60{
                        punkteKontra += 2
                    }
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 2
                    }
                    gewinner = .kontra
                }
            case "Schwarz":
                if spiel.kontraAugen == 0{
                    punkteRe += 4
                    gewinner = .re
                }else{
                    punkteKontra += 2
                    
                    if spiel.kontraAugen >= 30{
                        punkteKontra += 2
                    }
                    if spiel.kontraAugen >= 60{
                        punkteKontra += 2
                    }
                    if spiel.kontraAugen >= 90{
                        punkteKontra += 2
                    }
                    gewinner = .kontra
                }
                
            default:
                gewinner = .notPlaying
            }
            
        }else{
            if spiel.reAugen > 120 {
                gewinner = .re
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
                    punkteRe += 2
                    gewinner = .re
                }
                
            case "keine 60":
                if spiel.reAugen < 60 {
                    punkteKontra += 2
                    gewinner = .kontra
                } else {
                    punkteRe += 2
                    if spiel.reAugen >= 90 {
                        punkteRe += 2
                    }
                    gewinner = .re
                }
                
            case "keine 30":
                if spiel.reAugen < 30 {
                    punkteKontra += 3
                    gewinner = .kontra
                } else {
                    punkteRe += 2
                    if spiel.reAugen >= 60 {
                        punkteRe += 2
                    }
                    if spiel.reAugen >= 90 {
                        punkteRe += 2
                    }
                    gewinner = .re
                }
                
            case "Schwarz":
                if spiel.reAugen == 0 {
                    punkteKontra += 4
                    gewinner = .kontra
                } else {
                    punkteRe += 2
                    
                    if spiel.reAugen >= 30 {
                        punkteRe += 2
                    }
                    if spiel.reAugen >= 60 {
                        punkteRe += 2
                    }
                    if spiel.reAugen >= 90 {
                        punkteRe += 2
                    }
                    gewinner = .re
                }
                
            default:
                gewinner = .notPlaying
            }
        }else {
            if spiel.kontraAugen >= 120 {
                gewinner = .kontra
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
        if let bockList = list.block["Böcke"],
           let punkteList = list.block["Punkte"]
           {
            
            let bock = bockList[punkteList.count] // Sicherer Zugriff auf den Bock-Wert
            
            punkte *= Int(pow(2.0, Double(bock))) // pow() gibt Double zurück → Umwandlung in Int
            print("punkte x2")
        }else{
            print("nicht geladen")
        }
        
        
        // Punktvergabe für jedes Teammitglied
        for (key, partei) in spiel.teams {
            // Hole den letzten Punktestand des Spielers oder setze ihn auf 0
            let letzterPunktestand = list.block[key]?.last ?? 0

            // Falls der Spieler noch keine Einträge hat, initialisiere die Liste
            if list.block[key] == nil {
                list.block[key] = []
            }

            if partei == .re {
                let reCount = spiel.teams.values.filter { $0 == .re }.count
                if gewinner == .re {
                    // Gewinner bekommt Punkte
                    list.block[key]?.append(!list.nurMinus ? letzterPunktestand + (punkte * reCount == 3 ? 3 : 1) : letzterPunktestand)
                } else {
                    // Verlierer bekommt entweder -punkte oder bleibt bei nurMinus unverändert
                    var modifiziertePunkte = list.nurMinus ? punkte : -punkte
                    modifiziertePunkte *= reCount == 1 ? 3 : 1
                    list.block[key]?.append(letzterPunktestand + modifiziertePunkte)
                }
            } else if partei == .kontra {
                if gewinner == .kontra {
                    // Gewinner bekommt Punkte
                    list.block[key]?.append(!list.nurMinus ? letzterPunktestand + punkte : letzterPunktestand)
                } else {
                    // Verlierer bekommt entweder -punkte oder bleibt bei nurMinus unverändert
                    let modifiziertePunkte = list.nurMinus ? punkte : -punkte
                    list.block[key]?.append(letzterPunktestand + modifiziertePunkte)
                }
            } else {
                // Falls Spieler keiner Partei zugeordnet ist, bleibt sein Punktestand gleich
                list.block[key]?.append(letzterPunktestand)
            }
        }

        list.block["Punkte"]?.append(punkte)
        
        
        
        //Böcke
         if(
            (re && kontra) ||
            (kontra && gewinner == .re) ||
            (punkte == 0) ||
            (spiel.kontraAugen == 120) ||
            (spiel.reSonderpunkte.contains("Herzdurchlauf")) ||
            (spiel.kontraSonderpunkte.contains("Herzdurchlauf"))
                
         ){
             böcke()
         }
        
        
        
        return true
    }
    
    
    func böcke() {
        let p = list.players.count
        var runde = list.block["Punkte"]?.count ?? 0
        var i = 0

        

        while i < p {
            // Sicherstellen, dass "Böcke" mindestens bis "runde + i" gefüllt ist
            

            if list.block["Böcke"] == nil {
                list.block["Böcke"] = []
            }
            
            // Bock-Wert holen
            if let b = list.block["Böcke"]?[runde + i] {
                if list.maxDoppelBock {
                    if b < 2 {
                        list.block["Böcke"]?[runde + i] = b + 1
                        print("BOCK")
                        i += 1
                    } else {
                        runde += 1
                    }
                } else {
                    // Falls maxDoppelBock deaktiviert ist, erhöhe einfach i
                    list.block["Böcke"]?[runde + i] = b + 1
                    i += 1
                }
            } else {
                // Falls der Index nicht existiert, setze ihn auf 1
                list.block["Böcke"]?[runde + i] = 1
                print("!BOCK")
                i += 1
            }
        }
    }

    
    
}

