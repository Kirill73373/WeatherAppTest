import Foundation
import CoreLocation

final class WeatherService {
    
    //MARK: - Static Property
    
    static let shared = WeatherService()
    
    //MARK: - Private Property
    
    private let apiKey = "15fabd2e08e1366f344c06801ef7836f"
    private let urlString = "https://api.openweathermap.org"
    
    //MARK: - Public Method
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, model: @escaping (WeatherModel) -> Void) {
        var task: URLSessionTask?
        task?.cancel()
        task = nil
        
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string:  "\(self.urlString)/data/2.5/onecall?exclude=minutely&lang=ru&units=metric&appid=926247ac53ed30b659cab42495a479fd&lat=\(latitude)&lon=\(longitude)") else {
                return
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 300
            
            task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        model(DefaultHelper.shared.currentWeather ?? WeatherModel())
                    }
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    if let modelWeather = try? decoder.decode(WeatherModel.self, from: data) {
                        DispatchQueue.main.async {
                            model(modelWeather)
                        }
                    }
                }
            }
            task?.resume()
        }
    }
    
    func getCurrentListCountry(name: String, model: @escaping (List) -> Void) {
        var task: URLSessionTask?
        task?.cancel()
        task = nil
        
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: self.urlString + "/geo/1.0/direct?q=\(name)&limit=5&appid=\(self.apiKey)") else { return }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 300
            
            task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {  return }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    if let modelCountry = try? decoder.decode(List.self, from: data) {
                        DispatchQueue.main.async {
                            model(modelCountry)
                        }
                    }
                }
            }
            task?.resume()
        }
    }
}
