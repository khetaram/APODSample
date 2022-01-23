//
//  APODRouter.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

enum APODRouter: Router {
    case getPicOfTheDay(date: Date)

    var path: String {
        switch self {
        case .getPicOfTheDay:
            return "/planetary/apod"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .getPicOfTheDay:
            return .get
        }
    }

    var body: RequestBody? {
        switch self {
        case .getPicOfTheDay:
            return nil
        }
    }

    var queryParameters: [QueryParams: String] {
        switch self {
        case let .getPicOfTheDay(date):
            return [.apiKey: AppConfig.apiKey,
                    .date: date.stringWith(format: AppConfig.apodDateFormat)
            ]
        }
    }

    var headers: [Headers: String] {
        switch self {
        case .getPicOfTheDay:
            return [.contentType: "application/json"]
        }
    }
}
