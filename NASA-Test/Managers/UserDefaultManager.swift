//
//  UserDefaultManager.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()

    private let defaults = UserDefaults.standard

    enum Keys {
        case apodLastViewedDate

        var value: String {
            return String(reflecting: self)
        }
    }

    func save<T: Codable>(_ obj: T, forKey key: Keys) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(obj) {
            defaults.set(encoded, forKey: key.value)
        }
    }

    func get<T: Codable>(_ key: Keys) -> T? {
        if let obj = defaults.object(forKey: key.value) as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: obj)
        }
        return nil
    }
}
