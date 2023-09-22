import Foundation

final class DefaultHelper {
    
    private enum UDKey: String {
        case currentWeather
        case currentCountryName
    }
    
    static let shared = DefaultHelper()
    
    var currentWeather: WeatherModel? {
        get { userDefaults?.getObject(key: UDKey.currentWeather.rawValue, type: WeatherModel()) ?? nil }
        set { userDefaults?.setObject(newValue, key: UDKey.currentWeather.rawValue)}
    }
    
    var currentCountryName: String {
        get { getValue(.currentCountryName ) as? String ?? "" }
        set { setValue(newValue, key: .currentCountryName) }
    }
    
    private let suiteName = "WeatherAppTest"
    private lazy var userDefaults = UserDefaults(suiteName: suiteName)
    
    private func setValue(_ value: Any, key: UDKey) {
        userDefaults?.set(value, forKey: key.rawValue)
        userDefaults?.synchronize()
    }
    
    private func getValue(_ key: UDKey) -> Any? {
        return userDefaults?.value(forKey: key.rawValue)
    }
}
