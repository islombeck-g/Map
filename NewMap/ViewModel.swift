import Foundation
import SwiftUI
import MapKit
import SwiftData

class ViewModelo:NSObject, ObservableObject, CLLocationManagerDelegate {
//    MARK: init ViewModelo
    @Published var cameraPosition: MapCameraPosition = .region(.myRegion)
    @Published var settingsShetViewShow = false
    
    
//    MARK: route module
    @Published var routeMode = false
    @Published var isFirstPoint = true
    @Published var firstPoint :CLLocationCoordinate2D? = nil
    @Published var secondPoint :CLLocationCoordinate2D? = nil
    @Published var route:MKRoute?
    
    func getRoute(_ style : String) {
        
        let sourcePlacemark = MKPlacemark(coordinate: firstPoint!, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: secondPoint!, addressDictionary: nil)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        
        if style == "automobile" {
            request.transportType = .automobile
        } else {
            request.transportType = .walking
        }
        
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
    
//    MARK: map styles
    @Published var mapstiles:MapStyle = .standard
    func changeMapStyle0() { self.mapstiles = .standard }
    func changeMapStyle1() { self.mapstiles = .hybrid }
    
//    MARK: mapScale
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
    
//    MARK: new Point module
    @Published var addPointMode = false
    @Published var selectedCoordinatesToAddLocation: CLLocationCoordinate2D? = nil
    @Published var showPointSheetView = false
//    @Published var markers:[MKMapItem] = []
    @Published var searchText:String = ""
//    MARK: clean all
    func clean() {
        self.firstPoint = nil
        self.secondPoint = nil
        self.isFirstPoint = true
        self.routeMode = false
        self.route = nil
    }
}

//MARK: init location
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

//MARK: LocalItems
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
//    MARK: init hach Protocol
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
