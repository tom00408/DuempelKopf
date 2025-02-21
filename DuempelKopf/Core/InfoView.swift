//
//  InfoView.swift
//  DuempelKopf
//
//  Created by Tom Tiedtke on 20.02.25.
//

import SwiftUI

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                Text("""
            **Doppelkopf Spielwertung – Regeln & Punkteberechnung**
            
            1. **Bestimmung des Gewinnerteams**
               - Das Team mit mehr als 120 Augen gewinnt das Spiel.
               - `Re` gewinnt, wenn sie mehr als 120 Augen haben.
               - `Kontra` gewinnt, wenn sie mindestens 120 Augen haben.
            
            2. **Ansagen & Zusatzpunkte**
               - Spieler können spezielle Ansagen machen, um zusätzliche Punkte zu erhalten oder den Gegner stärker unter Druck zu setzen.
               - Beispiele für Ansagen:
                 - **„Keine 90“**: Falls das Gegnerteam unter 90 Augen bleibt, gibt es **+1 Punkt**.
                 - **„Keine 60“**: Falls das Gegnerteam unter 60 Augen bleibt, gibt es **+2 Punkte**.
                 - **„Keine 30“**: Falls das Gegnerteam unter 30 Augen bleibt, gibt es **+3 Punkte**.
                 - **„Schwarz“**: Falls das Gegnerteam **0 Augen** hat, gibt es **+4 Punkte**.
            
            3. **Grundpunkte für das Gewinnerteam**
               - **Sieg mit 121 – 150 Augen**: +1 Punkt
               - **Sieg mit 151+ Augen**: +2 Punkte
               - **Sonderfälle:**
                 - Gegner unter 60 Augen: +1 Punkt
                 - Gegner unter 30 Augen: +1 Punkt
                 - Gegner mit 0 Augen (Schwarz): +1 Punkt
            
            4. **Sonderpunkte**
               - Für bestimmte Ereignisse gibt es Extrapunkte:
                 - **Doppelkopf (ein Stich mit 40+ Punkten)**: +1 Punkt
                 - **Fuchs gefangen (Karo-Ass des Gegners genommen)**: +1 Punkt
                 - **Karlchen (Kreuz Bube im letzten Stich)**: +1 Punkt
                 - **Herzdurchmarsch (Alle Herzstiche von einem Team gemacht)**: Sonderregel (Böcke möglich)
            
            5. **Punktmultiplikation durch Bockrunden**
               - Falls eine Bockrunde aktiv ist, werden die Punkte **verdoppelt**.
               - Falls mehrere Bockrunden aktiv sind, kann es eine **weitere Verdopplung** geben.
               - Maximalwert für einen Bock ist **2x**.
            
            6. **Finale Punktvergabe**
               - Die Punkte werden mit den Sonderpunkten verrechnet.
               - Das Gewinnerteam bekommt die Gesamtpunkte positiv gutgeschrieben.
               - Das Verliererteam erhält dieselben Punkte als negative Wertung (außer `nurMinus` ist aktiv).
            
            7. **Besondere Bock-Situationen**
               - Falls folgende Bedingungen erfüllt sind, startet eine **neue Bockrunde**:
                 - Re und Kontra haben beide eine Ansage gemacht.
                 - Kontra hat gewonnen, obwohl Re angesagt hatte.
                 - Das Spiel endete unentschieden (beide Teams genau 120 Augen).
                 - Ein **Herzdurchlauf** wurde gespielt.
            
            """) .padding()
                
                NavigationLink{
                    PrivacyPolicyView()
                }label:{
                    Text("Datenschutzbestimmungen")
                    
                }
                
                
               
            }
        }
        .navigationTitle("Spielwertung – Info")
    }
}

#Preview {
    InfoView()
}
