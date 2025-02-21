import SwiftUI
import SwiftData
import Charts

struct SingleListView: View {
    
    @StateObject var viewModel: SingleListViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showDeleteAlert = false
    @State private var showSpielHinzufügen = false
    
    @State private var inEuros : Bool = false
    @State private var table : Bool = true
    
    init(list: List) {
        _viewModel = StateObject(wrappedValue: SingleListViewModel(list: list))
    }
    let slimSize : CGFloat = 16
    let notSlimSize : CGFloat = 32
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var slim: Bool {
        screenWidth < 400
    }
    
    
    
    
    private var länge: CGFloat {
        if let l =  viewModel.list.block["Böcke"]?.count{
            return l > 600 ? CGFloat(l * 10) : 600
        }else{
            return 600
        }
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
             TABELLE / STANDINGS
             */
            if table {
                ScrollView{
                    HStack(alignment: .top){
                        ForEach(viewModel.list.block.keys.sorted(), id: \.self){ key in
                            if key != "Böcke" && key != "Punkte" {
                                VLine(länge)
                                Spacer()
                                VStack{
                                    Text(key)
                                        .fontWeight(.bold)
                                    if let werte = viewModel.list.block[key]{
                                        ForEach(werte, id: \.self){ wert in
                                            if inEuros, let e = viewModel.list.einsatz{
                                                Text("\(String(format: "%.2f €", Double(wert) * e))")
                                                    .font(.system(size : slim ? slimSize : notSlimSize))
                                            }
                                            else
                                            {
                                                Text("\(wert)")
                                                    .font(.system(size: slim ? slimSize : notSlimSize))
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                
                            }
                        }
                        
                        VLine(länge,2)
                        Spacer()
                        //Punkte
                        VStack{
                            Text("P")
                                .fontWeight(.bold)
                            if let werte = viewModel.list.block["Punkte"]{
                                ForEach(werte, id: \.self){ wert in
                                    if inEuros, let e = viewModel.list.einsatz{
                                        Text("\(String(format: "%.2f €", Double(wert) * e))")
                                            .font(.system(size: slim ? slimSize :notSlimSize))
                                    }
                                    else
                                    {
                                        Text("\(wert)")
                                            .font(.system(size: slim ? slimSize :notSlimSize))
                                    }
                                    
                                }
                            }
                        }
                        Spacer()
                        VLine(länge)
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
                    Spacer()
                    
                }.padding()
            }else{
                ScrollView{
                    Chart {
                        ForEach(viewModel.list.block.keys.sorted(), id: \.self) { key in
                            if key != "Böcke" && key != "Punkte" ,let liste = viewModel.list.block[key] {
                                ForEach(Array(liste.enumerated()), id: \.offset) { index, wert in
                                    LineMark(
                                        x: .value("Runde", index + 1),
                                        y: .value("Punkte", wert)
                                    )
                                }
                                .foregroundStyle(by: .value("Spieler", key))
                            }
                        }
                    }
                    .chartXScale(
                        domain: 1...(viewModel.list.block["Punkte"]?.count ?? 5)
                    )
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                }
            }
            
            
            
            
            
            //ICONS
            HStack{
                
                Button{
                    inEuros.toggle()
                }label: {
                    Image(systemName: inEuros ? "p.circle.fill" : "eurosign.ring.dashed")
                        .font(.system(size: 40))
                        .accentColor(.blue)
                }
                Button{
                    table.toggle()
                }label: {
                    Image(systemName: table ? "chart.line.uptrend.xyaxis" : "tablecells")
                        .font(.system(size: 40))
                        .accentColor(.green)
                }
                
                
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash.circle")
                        .font(.system(size: 50))
                        .accentColor(.red)
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
    NavigationStack{
        SingleListView(list: List.sample)
    }
}
