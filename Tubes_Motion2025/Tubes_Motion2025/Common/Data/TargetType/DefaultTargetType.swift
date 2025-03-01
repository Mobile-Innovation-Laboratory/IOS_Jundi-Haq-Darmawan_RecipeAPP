//
//  DefaultTargetType.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//
import Foundation
import Moya

protocol DefaultTargetType: TargetType {
    var parameters: [String: Any] {
        get
    }
}

extension DefaultTargetType {
    public var baseURL: URL {
        return URL(string: "https://dummyjson.com") ?? (NSURL() as URL)
    }

    var parameterEncoding: Moya.ParameterEncoding {
        JSONEncoding.default
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }

    public var headers: [String: String]? {
        return [:]
    }
}
