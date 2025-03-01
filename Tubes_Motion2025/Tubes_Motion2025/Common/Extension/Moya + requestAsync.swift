//
//  Moya + requestAsync.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//

import Foundation
import Moya

extension MoyaProvider{
    func requestAsync<T: Codable>(_ target: Target, model: T.Type) async throws -> T{
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result{
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                    print(moyaError)
                case .success(let response):
                    let jsondecoder = JSONDecoder()
                    jsondecoder.dateDecodingStrategy = .iso8601
                    do{
                        let decodedata = try jsondecoder.decode(model.self, from:response.data)
                        continuation.resume(returning: decodedata)
                    } catch{
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
