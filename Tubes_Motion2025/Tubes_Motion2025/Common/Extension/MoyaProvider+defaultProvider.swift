//
//   MoyaProvider+defaultProvider.swift
//  Tubes_Motion2025
//
//  Created by Jundi HD on 27/02/25.
//

import Foundation
import Moya

extension MoyaProvider{
    static func defaultProvider() -> MoyaProvider{
        return MoyaProvider(plugins: [
            NetworkLoggerPlugin()
        ])
    }
}
