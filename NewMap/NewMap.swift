import SwiftUI
import MapKit

struct NewMap: View {
    
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
    
    @StateObject var viewModel = ViewModelo()
    
    var body: some View {
        
        NavigationStack {
            
            MapReader{ reader in
                
                Map(position: $viewModel.cameraPosition) {
                    
                    if self.viewModel.pickMode {
                        if let pl = pinLocation {
                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                        }
                    }
                    
                }
                .mapControls{
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                }
                .onTapGesture(perform: { screenCoord in
                    pinLocation = reader.convert(screenCoord, from: .local)
                    placeAPin = false
                })
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            
                            self.viewModel.shetViewShow = true
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.system(size: 30))
                        }
                        Spacer()
                            .frame(width: 20)
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: self.$viewModel.shetViewShow) {
                    SheetView()
                .environmentObject(self.viewModel)
                .presentationDetents([.medium, .large])
                }
       
    }
}

#Preview {
    NewMap()
}

