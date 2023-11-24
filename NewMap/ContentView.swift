import SwiftUI
import MapKit

struct ContentView: View {
    @State private var annotations = [MKPointAnnotation]()

    var body: some View {
        VStack {
            MapView(annotations: $annotations)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    let newLocation = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
                    let newAnnotation = MKPointAnnotation()
                    newAnnotation.coordinate = newLocation
                    annotations.append(newAnnotation)
                }

            if let coordinate = annotations.first?.coordinate {
                Text("Selected coordinates: \(coordinate.latitude), \(coordinate.longitude)")
            }
        }
    }
}

class MapViewModel: ObservableObject {
    @Published var selectedCoordinate: CLLocationCoordinate2D?
}

struct MapView: UIViewRepresentable {
    @Binding var annotations: [MKPointAnnotation]
    @StateObject private var viewModel = MapViewModel()

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }

        if let coordinate = viewModel.selectedCoordinate {
            view.setCenter(coordinate, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var viewModel: MapViewModel

        init(viewModel: MapViewModel) {
            self.viewModel = viewModel
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let coordinate = view.annotation?.coordinate {
                viewModel.selectedCoordinate = coordinate
            }
        }
    }
}
