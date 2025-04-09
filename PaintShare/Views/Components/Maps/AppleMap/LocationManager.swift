//
//  LocationManager.swift
//  PaintShare
//
//  Created by Lee on 2022/6/6.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.898150, longitude: -77.034340),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    private var hasSetRegion = false
    
    let locationManager = CLLocationManager()
    
    @Published var centerCoordinate = CLLocation()
    
    var searchManager:MKLocalSearchCompleter? = MKLocalSearchCompleter()
    
    var searchComplete: ((CLLocation?) -> Void)?
    
    var didUpdateLocationsComplete: ((CLLocation?) -> Void)?
    
    var frist: CLLocation?
    var searchLocation: CLLocation?
    var isSearch: Bool = false
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
        searchManager?.delegate = self
        
        searchComplete = { region in
            guard let region = region else {
                return
            }
            self.centerCoordinate = region
        }
    }
    
    
    
    static func getAddress(location: CLLocation? = nil, address:((String?) -> Void)?) {
            //CLLocation
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                if error != nil {
                    return
                }
                
                if let place = placemarks?[0]{
                    // Country Province City District Street Name Country Code Postal Code.
                    let name = place.name ?? ""
                    let thoroughfare = place.thoroughfare ?? ""
                    let subThoroughfare = place.subThoroughfare ?? ""
                    let administrativeArea = place.administrativeArea ?? ""
                    let locality = place.locality ?? ""
                    let subLocality = place.subLocality ?? ""
                    let subAdministrativeArea = place.subAdministrativeArea ?? ""
                    let postalCode = place.postalCode ?? ""
                    let isoCountryCode = place.isoCountryCode ?? ""
                    let country = place.country ?? ""
                    let inlandWater = place.inlandWater ?? ""
                    let ocean = place.ocean ?? ""
                    let areasOfInterest = place.areasOfInterest ?? [""]
                    
                    let addressLines =  administrativeArea + locality + subLocality + thoroughfare + name
                    let ss = "\(subThoroughfare),\(subAdministrativeArea),\(postalCode),\(isoCountryCode),\(country),\(inlandWater),\(ocean),\(areasOfInterest)"
                    address?(addressLines)
                } else {
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let last = locations.last {
            self.currentLocation = last
//            if !hasSetRegion {
                self.region = MKCoordinateRegion(center: last.coordinate,
                                                 span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//                hasSetRegion = true
//            }
//            LocationManager.getAddress(location: last)
            if self.didUpdateLocationsComplete != nil {
                self.didUpdateLocationsComplete?(last)
            }
            
            
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrintLog(message:"Error - suggesting a location: \(error.localizedDescription)")
    }
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func search(_ searchName: String?) -> ((CLLocation?) -> Void)? {
        guard let locationName = searchName else {
            return nil
        }
        if let search = searchManager, search.isSearching {
            return nil
        }
        isSearch = true
        searchManager = MKLocalSearchCompleter()
        searchManager?.delegate = self
        searchManager?.queryFragment = locationName
        return searchComplete
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        guard let frist: MKLocalSearchCompletion = completer.results.first else {
            return
        }
        
        debugPrintLog(message:"\(frist)")

        if let current = currentLocation {
            var coord: CLLocationCoordinate2D!
            coord = CLLocationCoordinate2DMake(current.coordinate.latitude, current.coordinate.longitude);
            var region = MKCoordinateRegion(center: coord, latitudinalMeters: 100, longitudinalMeters: 100);
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = frist.title
            let search = MKLocalSearch.init(request:request)
            search.start { result, error in
                guard let response = result else {
                    debugPrintLog(message:"There was an error searching for: \(String(describing: request.naturalLanguageQuery)) error: \(String(describing: error))")
                    return
                }
                debugPrintLog(message:"Inside function")
                let station1 = response.mapItems[0].name
                if let loc = response.mapItems[0].placemark.location {
                    self.searchLocation = loc
                    self.searchComplete?(loc)
                }
                debugPrintLog(message:"\(station1)")
            }
        }
        searchManager = nil
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        debugPrintLog(message:"Error - suggesting a location: \(error.localizedDescription)")
    }
}
