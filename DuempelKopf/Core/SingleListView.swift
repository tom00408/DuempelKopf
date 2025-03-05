import SwiftUI
import SwiftData
import Charts

struct SingleListView: View {
    
    @StateObject var viewModel: SingleListViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showDeleteAlert = false
    @State private var showPottAlert = false
    @State private var showBöckeAlert = false
    @State private var showSpielHinzufügen = false
    
    @State private var inEuros : Bool = false
    @State private var table : Bool = true
    
    init(list: List) {
        _viewModel = StateObject(wrappedValue: SingleListViewModel(list: list))
    }
    private var fontSize : CGFloat {
        slim ? inEuros ? 10 :16: 32
    }
    
    
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var slim: Bool {
        screenWidth < 450
    }
    
    
    
    
    private var länge: CGFloat {
        if let l =  viewModel.list.block["Böcke"]?.count{
            return l > 600 ? CGFloat(l * 10) : 600
        }else{
            return 600
        }
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            HStack{
                VStack {
                    /*
                     TABELLE / STANDINGS
                     */
                    if table {
                        SingleListHeader(viewModel.list)
                        ScrollView{
                            HStack(alignment: .top){
                                ForEach(viewModel.list.block.keys.sorted(), id: \.self){ key in
                                    if key != "Böcke" && key != "Punkte" {
                                        VLine(länge)
                                        Spacer()
                                        VStack{
                                            Text(key.prefix(slim ? 4: 10))
                                                .fontWeight(.bold)
                                            if let werte = viewModel.list.block[key]{
                                                ForEach(werte, id: \.self){ wert in
                                                    if inEuros, let e = viewModel.list.einsatz{
                                                        Text("\(String(format: "%.2f €", Double(wert) * e))")
                                                            .font(.system(size : fontSize))
                                                    }
                                                    else
                                                    {
                                                        Text("\(wert)")
                                                            .font(.system(size: fontSize))
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
                                                    .font(.system(size: fontSize))
                                            }
                                            else
                                            {
                                                Text("\(wert)")
                                                    .font(.system(size: fontSize))
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
                                                .font(.system(size: fontSize))
                                        }
                                    }
                                }
                                
                            }
                            Spacer()
                            
                        }.padding()
                            .background{
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(style: StrokeStyle(lineWidth: 1)
                                    )
                                .padding(8)}
                    }else{
                        ScrollView{
                            SingleListHeader(viewModel.list)
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
                    
                    
                    /*
                     1x Icons
                     */
                    
                    if !isLandscape{
                        //ICONS
                        HStack{
                            Spacer()
                            Button{
                                inEuros.toggle()
                                print("\(isLandscape)")
                            }label: {
                                Image(systemName: inEuros ? "p.circle.fill" : "eurosign.ring.dashed")
                                    .font(.system(size: 40))
                                    .accentColor(.blue)
                            }.disabled(viewModel.list.einsatz == nil)
                                .opacity(viewModel.list.einsatz == nil ? 0.5 : 1)
                            
                            
                            Spacer()
                            Button{
                                table.toggle()
                            }label: {
                                Image(systemName: table ? "chart.line.uptrend.xyaxis" : "tablecells")
                                    .font(.system(size: 40))
                                    .accentColor(.yellow)
                            }.disabled((viewModel.list.block["Punkte"]?.count ?? 0) < 2)
                                .opacity((viewModel.list.block["Punkte"]?.count ?? 0) < 2 ? 0.5 : 1)
                            
                            Spacer()
                            
                            
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
                            Spacer()
                            
                            
                            
                            Button{
                                showPottAlert = true
                            }label: {
                                Text("💰")
                                    .font(.system(size: 50))
                                    .cornerRadius(24)
                            }.padding(.horizontal)
                                .alert(
                                    "Gesamter Pott",
                                    isPresented: $showPottAlert){
                                    Button("Okay", role: .cancel) {
                                        print("okay")
                                    }
                                    } message:{
                                        Text("Der gesamte Pott beträgt: \(viewModel.getPott())")
                                    }
                            
                            
                            Button {
                                showBöckeAlert = true
                            } label: {
                                Text("🐐")
                                    .font(.system(size: 50))
                                    
                            }
                            .padding(.horizontal)
                            .alert("Liste löschen", isPresented: $showBöckeAlert) {
                                Button("Abbrechen", role: .cancel) {}
                                Button("Ja") {
                                    viewModel.böcke()
                                }
                            } message: {
                                Text("Du willst \(viewModel.list.players.count) Böcke hinzufügen.")
                            }
                            Spacer()

                            
                        }
                        .padding()
                        .background{
                            Color(.systemGray3)
                                .cornerRadius(24)
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(style: StrokeStyle(lineWidth: 3)
                                )}
                        Spacer()
                        
                                                
                    }
                    
                }//VStack
                
                
                /*
                 2x Icons
                 */
                if isLandscape{
                    //ICONS
                    VStack{
                        
                        Button{
                            inEuros.toggle()
                            print("\(isLandscape)")
                        }label: {
                            Image(systemName: inEuros ? "p.circle.fill" : "eurosign.ring.dashed")
                                .font(.system(size: 35))
                                .accentColor(.blue)
                        }.disabled(viewModel.list.einsatz == nil)
                            .opacity(viewModel.list.einsatz == nil ? 0.5 : 1)
                            .padding(.bottom,48)
                        
                        
                        
                        Button{
                            table.toggle()
                        }label: {
                            Image(systemName: table ? "chart.line.uptrend.xyaxis" : "tablecells")
                                .font(.system(size: 35))
                                .accentColor(.yellow)
                        }.disabled((viewModel.list.block["Punkte"]?.count ?? 0) < 2)
                            .opacity((viewModel.list.block["Punkte"]?.count ?? 0) < 2 ? 0.5 : 1)
                            .padding(.bottom,48)
                        
                        
                        
                        Button {
                            showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash.circle")
                                .font(.system(size: 35))
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
                    .padding(4)
                    .background{
                        Color(.systemGray3)
                            .cornerRadius(24)
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(style: StrokeStyle(lineWidth: 3)
                            )}
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
}


#Preview {
    NavigationStack{
        SingleListView(list: List.preview)
    }
}
