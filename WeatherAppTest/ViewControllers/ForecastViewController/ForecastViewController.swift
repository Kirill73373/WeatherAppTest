import UIKit
import CoreLocation

final class ForecastViewController: BaseController {
    
    //MARK: - UI
    
    private let forecastView = ForecastView()
    
    //MARK: - Service
    
    private let locationService = LocationService()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requesWeather(
            latitude: locationService.location?.latitude ?? 0,
            longitude: locationService.location?.longitude ?? 0
        )
    }
    
    //MARK: - Private Method
    
    private func bindUI() {
        tapPlus = { [weak self] in
            guard let self = self else { return }
            self.alert(title: "Tap Plus Button")
        }
    }
    
    private func requesWeather(latitude: CGFloat, longitude: CGFloat) {
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        WeatherService.shared.getCurrentWeather(latitude: latitude, longitude: longitude) { [weak self] model in
            guard let self = self else { return }
            self.locationService.geocoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.current) { placemarks, _ in
                
                let locality = placemarks?.first?.locality ?? (placemarks?.first?.name ?? DefaultHelper.shared.currentCountryName)
                
                self.forecastView.getCountryName(locality)
                self.forecastView.getItemsLanguage(model)
                
                DefaultHelper.shared.currentCountryName = locality
                DefaultHelper.shared.currentWeather = model
            }
        }
    }
    
    private func setupConstraints() {
        view.addSubview(forecastView)
        
        forecastView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
