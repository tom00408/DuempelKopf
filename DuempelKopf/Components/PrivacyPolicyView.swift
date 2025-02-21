import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("📜 Datenschutzerklärung")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("**Letzte Aktualisierung:** 21.02.2025")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                Group {
                    SectionView(title: "1. Verantwortlicher", content: """
                    Tom Tiedtke  
                    Brauweg 23 
                    tom00408@aol.com
                    """)

                    SectionView(title: "2. Erhobene Daten und Verwendungszweck", content: """
                    Wir sammeln und verarbeiten nur die Daten, die zur Nutzung unserer App erforderlich sind. Dazu gehören:
                    
                    - **Automatisch erfasste Daten:** Geräteinformationen, Nutzungsdaten, IP-Adresse  
                    - **Freiwillig bereitgestellte Daten:** Name, E-Mail-Adresse, Feedback
                    
                    Diese Daten helfen uns, die App bereitzustellen und zu verbessern.
                    """)

                    SectionView(title: "3. Speicherung und Löschung der Daten", content: """
                    - Wir speichern Ihre Daten nur so lange, wie es für den jeweiligen Zweck erforderlich ist.  
                    - Sie können jederzeit die Löschung Ihrer Daten verlangen.
                    """)

                    SectionView(title: "4. Weitergabe an Dritte", content: """
                    Wir geben Ihre Daten **nicht** an Dritte weiter, außer es ist erforderlich oder gesetzlich vorgeschrieben.
                    """)

                    SectionView(title: "5. Ihre Rechte", content: """
                    Sie haben das Recht auf:
                    - **Auskunft** über gespeicherte Daten  
                    - **Löschung** oder **Berichtigung** Ihrer Daten  
                    - **Widerspruch gegen die Verarbeitung**
                    """)

                    SectionView(title: "6. Änderungen dieser Datenschutzerklärung", content: """
                    Wir können diese Datenschutzerklärung aktualisieren. Die aktuellste Version ist immer in der App abrufbar.
                    """)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Datenschutz")
    }
}

struct SectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.blue)
            
            Text(content)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
