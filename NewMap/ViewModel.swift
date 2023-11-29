import Foundation
import SwiftUI
import MapKit
import SwiftData

class ViewModelo:NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cameraPosition: MapCameraPosition = .region(.myRegion)
    
    @Published var settingsShetViewShow = false
    
    @Published var pickMode = false
    
    @Published var isFirstPoint = true
    
    @Published var firstPoint :CLLocationCoordinate2D? = nil
    
    @Published var secondPoint :CLLocationCoordinate2D? = nil
    
    @Published var route:MKRoute?
    
    func getRoute() {
        
        let sourcePlacemark = MKPlacemark(coordinate: firstPoint!, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: secondPoint!, addressDictionary: nil)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let route = response?.routes.first else {
                if let error = error {
                    print("Error getting directions: \(error.localizedDescription)")
                }
                return
            }
            
            self.route = route
            self.settingsShetViewShow = false
        }
    }
    
    
    @Published var mapstiles:MapStyle = .standard
    func changeMapStyle0() { self.mapstiles = .standard }
    func changeMapStyle1() { self.mapstiles = .hybrid }
    
    
    @Published var scale: Double = 1.0
    
    @Published var scaleString = "1.0"
    
    func updateData() {
        self.scale = Double(scaleString)!
        self.settingsShetViewShow = false
    }
    
    func resetData() {
        self.scale = 1.0
        self.settingsShetViewShow = false
    }
    
    @Published var addPointMode = false
    @Published var selectedCoordinatesToAddLocation: CLLocationCoordinate2D? = nil
    @Published var showPointSheetView = false
    
    @Published var markers:[MKMapItem] = []
    
    @Published var searchText:String = ""
    
    func clean() {
        self.firstPoint = nil
        self.secondPoint = nil
        self.isFirstPoint = true
        self.pickMode = false
        self.route = nil
    }
    
}


extension CLLocationCoordinate2D {
    static var mylocation: CLLocationCoordinate2D {
        return .init(latitude: 55.792091, longitude: 49.122082)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .mylocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}


class mapViewCoordinator: NSObject, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .orange
        render.lineWidth = 5
        return render
    }
    
}

@Model
class LocalItems:Hashable {
    var name:String
    var coorLa:CLLocationDegrees
    var coorLo:CLLocationDegrees
    
    init(name: String, coorLa: CLLocationDegrees, coorLo: CLLocationDegrees) {
        self.name = name
        self.coorLa = coorLa
        self.coorLo = coorLo
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(coorLa)
        hasher.combine(coorLo)
    }
    
    static func == (lhs: LocalItems, rhs: LocalItems) -> Bool {
        return lhs.name == rhs.name &&
        lhs.coorLa == rhs.coorLa &&
        lhs.coorLo == rhs.coorLo
    }
}


//@Model
//class SelectedMarkers {
//
//   var market: MKMapItem
//    var name: String
//
//    init(market: MKMapItem, name: String) {
//        self.market = market
//        self.name = name
//    }
//}
