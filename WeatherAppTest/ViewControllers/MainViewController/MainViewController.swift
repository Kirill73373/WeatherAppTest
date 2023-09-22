import UIKit
import CoreLocation

final class MainViewController: BaseController {
    
    //MARK: - UI
    
    private let mainView = MainView()
    
    //MARK: - Service
    
    private let locationService = LocationService()
    
    //MARK: - Life Cycle
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupConstraints()
        requestLocationStatus()
    }
    
    //MARK: - Private Method
    
    private func bindUI() {
        tapPlus = { [weak self] in
            guard let self = self else { return }
            self.alert(title: "Tap Plus Button")
        }
        
        mainView.flow = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .textFieldDidChangeSelection(let text):
                if text.isEmpty {
                    self.requesWeather(
                        latitude: self.locationService.location?.latitude ?? 0,
                        longitude: self.locationService.location?.longitude ?? 0,
                        isCurrent: true
                    )
                } else {
                    WeatherService.shared.getCurrentListCountry(name: text) { [weak self] model in
                        guard let self = self else { return }
                        self.requesWeather(
                            latitude: model.first?.lat ?? 0,
                            longitude: model.first?.lon ?? 0
                        )
                    }
                }
            }
        }
    }
    
    private func requestLocationStatus() {
        switch locationService.locationManager.authorizationStatus {
        case .denied:
            self.showAlertOpenSetting()
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.requesWeather(
                    latitude: self.locationService.location?.latitude ?? 0,
                    longitude: self.locationService.location?.longitude ?? 0,
                    isCurrent: true
                )
            }
        default:
            break
        }
        
        locationService.locationStatus = { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .denied:
                self.showAlertOpenSetting()
            case .authorizedAlways, .authorizedWhenInUse:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.requesWeather(
                        latitude: self.locationService.location?.latitude ?? 0,
                        longitude: self.locationService.location?.longitude ?? 0,
                        isCurrent: true
                    )
                }
            default:
                break
            }
        }
    }
    
    private func requesWeather(latitude: CGFloat, longitude: CGFloat, isCurrent: Bool = false) {
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        WeatherService.shared.getCurrentWeather(latitude: latitude, longitude: longitude) { [weak self] model in
            guard let self = self else { return }
                        
            self.locationService.geocoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.current) { placemarks, _ in
                
                let locality = placemarks?.first?.locality ?? (placemarks?.first?.name ?? DefaultHelper.shared.currentCountryName)
                                
                self.mainView.getInformation(
                    locality: locality,
                    temperature: "\(model.current.temp)",
                    temperatureC: model.current.temp
                )
                
                if isCurrent {
                    DefaultHelper.shared.currentCountryName = locality
                    DefaultHelper.shared.currentWeather = model
                }
            }
        }
    }
    
    private func showAlertOpenSetting() {
        alert(title: "Attention", subTitle: "You do not have access to the location. Please go to settings") {
            guard let urlSetting = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(urlSetting)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
