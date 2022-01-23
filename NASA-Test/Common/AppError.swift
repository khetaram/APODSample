//
//  AppError.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

struct APIError: Codable, LocalizedError {
    let code: Int
    let msg: String

    var errorDescription: String? {
        return msg
    }
}

enum AppError: LocalizedError {
    case jsonParseError
    case nullResponseData

    var errorDescription: String? {
        switch self {
        case .jsonParseError:
            return "Something went wrong while parsing"
        case .nullResponseData:
            return "Something went wrong while getting data"
        }
    }
}
