import SwiftUI
import MapKit

struct NewMap: View {
    
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    @StateObject var viewModel = ViewModelo()
    
    var body: some View {
        
        NavigationStack {
            
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
                }
                .scaleEffect(CGFloat(self.viewModel.scale), anchor: .center)
                .mapStyle(self.viewModel.mapstiles)
                .mapControls {
                    MapUserLocationButton()
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
                .safeAreaInset(edge: .bottom) {
                    VStack(spacing: 10) {
                        
                        Group {
                            HStack {

                                Spacer()
                                
                                Button {
                                    
                                    if self.viewModel.addPointMode == false {
                                        self.viewModel.selectedCoordinatesToAddLocation = nil
                                    }
                                    
                                    self.viewModel.addPointMode.toggle()
                                    self.viewModel.pickMode = false
                                    
                                } label: {
                                    Image(systemName: "plus.app")
                                        .font(.system(size: 23))
                                        .padding(.all, 10)
                                        .foregroundStyle(self.viewModel.addPointMode == true ? .white : .blue)
                                }
                                .background(self.viewModel.addPointMode == true ? .orange : .white.opacity(0.7))
                                .clipShape(.rect(cornerRadius: 8))
                            }
                            .padding(.trailing, 5)
                        }
                        
                        HStack {

                            Spacer()
                            
                            Button {
                                
                                self.viewModel.changeMapStyle1()
                                
                            } label: {
                                Image(systemName: "map.fill")
                                    .font(.system(size: 23))
                                    .padding(.all, 10)
                            }
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                        .padding(.trailing, 5)
                        
                        HStack {

                            Spacer()
                            
                            Button {
                                
                                self.viewModel.changeMapStyle0()
                                
                            } label: {
                                Image(systemName: "map")
                                    .font(.system(size: 23))
                                    .padding(.all, 10)
                            }
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                        .padding(.trailing, 5)
                        
                        HStack {

                            Spacer()
                            
                            Button {
                                
                                self.viewModel.pickMode.toggle()
                                self.viewModel.addPointMode = false
                                
                            } label: {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 23))
                                    .padding(.all, 10)
                            }
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                        .padding(.trailing, 5)
                        
                        HStack {

                            Spacer()
                            
                            Button {
                                
                                self.viewModel.settingsShetViewShow = true
                                
                            } label: {
                                Image(systemName: "square.and.arrow.up.fill")
                                    .font(.system(size: 23))
                                    .padding(.all, 10)
                            }
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                        .padding(.trailing, 5)
                        .padding(.bottom, 30)
                        

                    }
                    
                    
                }
            }
        }
        .sheet(isPresented: self.$viewModel.settingsShetViewShow) {
            SheetView()
                .environmentObject(self.viewModel)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: Binding(
            get: {
                self.viewModel.selectedCoordinatesToAddLocation != nil
            },
            set: { _ in
                self.viewModel.selectedCoordinatesToAddLocation = nil
            })
        ) {
            AddNewPositionSheetView()
                .environmentObject(self.viewModel)
                .presentationDetents([.height(150) , .large])
        }
    }
}

#Preview {
    NewMap()
}
