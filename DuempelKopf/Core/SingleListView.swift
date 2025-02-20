import SwiftUI
import SwiftData

struct SingleListView: View {
    
    @StateObject var viewModel: SingleListViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showDeleteAlert = false
    @State private var showSpielHinzufügen = false
    
    init(list: List) {
        _viewModel = StateObject(wrappedValue: SingleListViewModel(list: list))
    }
    
    var body: some View {
        
        VStack {
            
            
            Text(viewModel.list.name)
                .font(.system(size: 48, weight: .bold, design: .serif))
             
            HStack {
                if let e = viewModel.list.einsatz {
                    if e >= 1 {
                        ListenFeatureView("\(e)€ pro Punkt")
                    }else{
                        ListenFeatureView("\(e*100)ct pro Punkt")
                    }
                }
                if viewModel.list.maxDoppelBock {
                    ListenFeatureView("Max DoppelBock")
                }
                if viewModel.list.nurMinus {
                    ListenFeatureView("Nur Minus")
                }
            }
            
            Text(viewModel.list.info)
                .font(.system(size: 24, weight: .light, design: .serif))
            
            /*
             SPIEL HINZUFÜGEN
             */
            /*
            Button {
                showSpielHinzufügen.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text("Spiel hinzufügen")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "document.badge.plus.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            */
            /*
             TABELLE / STANDINGS
             */
            ScrollView{
                HStack(alignment: .top){
                    ForEach(viewModel.list.block.keys.sorted(), id: \.self){ key in
                        if key != "Böcke" && key != "Punkte" {
                            VLine(400)
                            VStack{
                                Text(key)
                                    .fontWeight(.bold)
                                if let werte = viewModel.list.block[key]{
                                    ForEach(werte, id: \.self){ wert in
                                        Text("\(wert)")
                                    }
                                }
                            }
                            
                        }
                    }
                    Spacer()
                    VLine(400,2)
                    Spacer()
                    //Punkte
                    VStack{
                        Text("P")
                            .fontWeight(.bold)
                        if let werte = viewModel.list.block["Punkte"]{
                            ForEach(werte, id: \.self){ wert in
                                Text("\(wert)")
                            }
                        }
                    }
                    Spacer()
                    VLine(400)
                    // BÖcke
                    VStack{
                        Text("  ")
                        if let werte = viewModel.list.block["Böcke"]{
                            ForEach(werte, id: \.self){ wert in
                                Text(wert == 0 ? " " : wert == 1 ? "🐐" : wert == 2 ? "🐐🐐" : "\(wert)🐐")
                                //.font(.system(size: 14))
                            }
                        }
                    }
                    
                }
            }.padding()

            
            
            
            Spacer()
            
            // LISTE LÖSCHEN
            Button {
                showDeleteAlert = true
            } label: {
                HStack {
                    Spacer()
                    Text("Liste löschen")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            .padding(.horizontal)
            .alert("Liste löschen", isPresented: $showDeleteAlert) {
                Button("Abbrechen", role: .cancel) {}
                Button("Löschen", role: .destructive) {
                    viewModel.deleteList(context: context, dismiss: dismiss)
                }
            } message: {
                Text("Bist du sicher, dass du diese Liste löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.")
            }
        }
        .background(Color(.systemGray4))
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Spiel Hinzufügen"){
                    showSpielHinzufügen.toggle()
                }
            }
        }
        .sheet(isPresented: $showSpielHinzufügen) {
            SpielHinzufuegenView(viewModel: viewModel)
                
        }
    }
}

#Preview {
    NavigationView{
        SingleListView(list: List.sample)
    }
}
