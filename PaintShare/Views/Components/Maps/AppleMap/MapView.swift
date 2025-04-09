//
//  MapView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/6.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocation
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.mapType = .standard
        mapView.userTrackingMode = .none
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
//        let coordinate = CLLocationCoordinate2D(
//                    latitude: 34.011286, longitude: -116.166868)
//        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        guard let centerCoordinate = centerCoordinate else {
//            return
//        }
        let region = MKCoordinateRegion(center: centerCoordinate.coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        view.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            debugPrintLog(message:mapView.centerCoordinate)
            let defaults = UserDefaults.standard
            defaults.set(mapView.centerCoordinate.latitude, forKey: Constants.CENTER_LAT)
            defaults.set(mapView.centerCoordinate.longitude, forKey: Constants.CENTER_LNG)
            let objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = mapView.centerCoordinate
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotation(objectAnnotation)
            if let location = mapView.userLocation.location {
                parent.centerCoordinate = location
            }
            
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
