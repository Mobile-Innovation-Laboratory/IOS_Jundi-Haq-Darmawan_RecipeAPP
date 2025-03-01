//
//  Encodable + toJson.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//
import Foundation
extension Encodable{
    func toJson() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
              let json = dictionary as? [String: Any] else{
            return [:]
        }
        return json
    }
    func toJsonData() -> Data{
        guard let data = try? JSONEncoder().encode(self) else{
            return Data()
        }
        return data
    }
}
