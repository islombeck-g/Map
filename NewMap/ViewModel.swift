import Foundation
import SwiftUI
import MapKit


class ViewModelo: ObservableObject {
    
    @Published var cameraPosition: MapCameraPosition = .region(.myRegion)
    @Published var shetViewShow = false
    
    @Published var pickMode = false
    
}


extension CLLocationCoordinate2D {
    static var mylocation: CLLocationCoordinate2D {
        return .init(latitude: 37.3346, longitude: -122.0090)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .mylocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
