import SwiftUI
import MapKit

struct ExampleView: View {
    
    @EnvironmentObject var viewModel: ViewModelo
    @State var placeAPin = false
    @State var pinLocation :CLLocationCoordinate2D? = nil
   
    var body: some View {
        ZStack {
            MapReader { reader in
                
                Map {
                    if self.viewModel.addPointMode {
                        if let pl = self.viewModel.selectedCoordinatesToAddLocation {
                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
                                .tint(Color.orange)
                        }
                    }
                }
                .onTapGesture(perform: { screenCoord in
                    
                    if self.viewModel.addPointMode {
                        withAnimation {
                            self.viewModel.selectedCoordinatesToAddLocation = reader.convert(screenCoord, from: .local)!
                        }
                        
                    }
                })
                
                
                
                
            }
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    SidePanelView()
                        .environmentObject(self.viewModel)
                }
                
            }
            
            
        }
    }
}

#Preview {
    ExampleView()
        .environmentObject(ViewModelo())
}




//
//import SwiftUI
//import MapKit
//
//struct ExampleView: View {
//    
//    @EnvironmentObject var viewModel: ViewModelo
//    @State var placeAPin = false
//    @State var pinLocation :CLLocationCoordinate2D? = nil
//   
//    var body: some View {
//        NavigationStack {
//            MapReader { reader in
//                
//                Map {
//                    if self.viewModel.addPointMode {
//                        if let pl = self.viewModel.selectedCoordinatesToAddLocation {
//                            Marker("(\(pl.latitude), \(pl.longitude))", coordinate: pl)
//                                .tint(Color.orange)
//                        }
//                    }
//                }
//                .onTapGesture(perform: { screenCoord in
//                    
//                    if self.viewModel.addPointMode {
//                        withAnimation {
//                            self.viewModel.selectedCoordinatesToAddLocation = reader.convert(screenCoord, from: .local)!
//                        }
//                        
//                    }
//                })
//                .safeAreaInset(edge: .bottom) {
//                    HStack {
//                        Spacer()
//                        SidePanelView()
//                            .environmentObject(self.viewModel)
//                            .background(.red)
//                    }
//                    
//                }
//                
//                
//                
//            }
//            
//            
//        }
//    }
//}
//
//#Preview {
//    ExampleView()
//        .environmentObject(ViewModelo())
//}
