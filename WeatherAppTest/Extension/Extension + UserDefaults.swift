import UIKit

extension UserDefaults {
    
    func getObject<T: Decodable>(key: String, type: T) -> T? {
        guard let decoded  = data(forKey: key) else{return nil}
        return try? JSONDecoder().decode(T.self, from: decoded)
    }

    func setObject<T: Encodable>(_ data: T, key: String) {
        if let object = try? JSONEncoder().encode(data) {
            set(object, forKey: key)
        }
    }
}
