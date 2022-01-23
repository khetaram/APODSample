//
//  HttpRequest.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

enum RequestBody {
    case json(body: JSONRequestBody)
}

struct JSONRequestBody {
    init<E: Encodable>(_ encodableValue: E) {
        jsonData = try? JSONEncoder().encode(encodableValue)
    }

    init(_ rawValue: [String: Any]) {
        jsonData = try? JSONSerialization.data(withJSONObject: rawValue, options: .prettyPrinted)
    }

    let jsonData: Data?
}
