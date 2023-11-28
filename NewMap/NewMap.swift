import SwiftUI
import MapKit
import SwiftData

struct NewMap: View {
    
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    @StateObject var viewModel = ViewModelo()
    
    @Query var items:[LocalItems]
    @Environment(\.modelContext) private var modelContext
    @State private var newItemText:String = ""
    
    var body: some View {
        
        ZStack {
            
            MapReader { reader in
                
                Map(position: self.$viewModel.cameraPosition) {
                    
                    if self.viewModel.pickMode {
                        
                        if let pl = self.viewModel.firstPoint {
                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                                .tint(.blue)
                        }
                        
                        if let pl = self.viewModel.secondPoint {
                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                                .tint(Color.red)
                        }
                        
                        if let route = self.viewModel.route {
                            MapPolyline(route)
                                .stroke(.blue, lineWidth: 4)
                        }
                    }
                    
                    if self.viewModel.addPointMode {
                        if let pl = self.viewModel.selectedCoordinatesToAddLocation {
                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                                .tint(Color.orange)
                        }
                    }
                    
                    ForEach(
                        self.items.filter { item in
                            self.viewModel.searchText.isEmpty || item.name.contains(self.viewModel.searchText)
                        }, id:\.self) { q in
                            
                            Marker(q.name, coordinate: CLLocationCoordinate2DMake(q.coorLa, q.coorLo))
                                .tint(.black)
                        }
                    
                }
                
                .scaleEffect(CGFloat(self.viewModel.scale), anchor: .center)
                .mapStyle(self.viewModel.mapstiles)
                .mapControls {
                    MapCompass()
                    MapScaleView()
                }
                
                .onTapGesture(perform: { screenCoord in
                    
                    if self.viewModel.addPointMode {
                        withAnimation {
                            self.viewModel.selectedCoordinatesToAddLocation = reader.convert(screenCoord, from: .local)!
                        }
                        
                    } else {
                        if self.viewModel.isFirstPoint {
                            self.viewModel.firstPoint = reader.convert(screenCoord, from: .local)
                        }
                        else {
                            self.viewModel.secondPoint = reader.convert(screenCoord, from: .local)
                        }
                    }
                    placeAPin = false
                })
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    SidePanelView()
                        .environmentObject(self.viewModel)
                }
            }
            
            VStack {
                TextField("Введите назавание точки", text: self.$viewModel.searchText)
                    .padding()
                    .background(Color.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                Spacer()
            }
            
                
        }
        
        .sheet(isPresented: self.$viewModel.settingsShetViewShow) {
            SheetView()
                .environmentObject(self.viewModel)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: self.$viewModel.showPointSheetView) {
            Group {
                TextField("Введите назавание точки", text: $newItemText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                HStack {
                    Button{
                        
                        if let pl = self.viewModel.selectedCoordinatesToAddLocation {
                            do {
                                let n = LocalItems(name: newItemText, coorLa: pl.latitude , coorLo: pl.longitude)
                                modelContext.insert(n)
                            }
                            
                            print("saved")
                            self.newItemText = ""
                            self.viewModel.showPointSheetView = false
                        }
                        
                    }label: {
                        Text("save")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .presentationDetents([.height(150)])
        }
    }
}

#Preview {
    NewMap()
}
