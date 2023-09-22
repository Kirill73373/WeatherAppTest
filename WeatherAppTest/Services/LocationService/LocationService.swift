import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    //MARK: - Private Property
    
    private(set) var locationManager = CLLocationManager()
    
    //MARK: - Public Property
    
    let geocoder = CLGeocoder()
    var location: CLLocationCoordinate2D?
    var locationStatus: ((CLAuthorizationStatus) -> Void)?
    
    //MARK: - Life Cycle
    
    override init() {
        super.init()
        locationServicesEnabled()
    }
    
    //MARK: - Private Method
    
    private func locationServicesEnabled() {
        DispatchQueue.global(qos: .background).async {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
}

//MARK: - CLLocation Manager Delegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus?(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
