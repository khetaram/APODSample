//
//  Router.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

protocol Router {
    var path: String { get }
    var httpMethod: HttpMethod { get }

    var baseQueryParameters: [QueryParams: String] { get }
    var queryParameters: [QueryParams: String] { get }

    var baseHeaders: [Headers: String] { get }
    var headers: [Headers: String] { get }

    var body: RequestBody? { get }
    var urlRequest: URLRequest { get }
}

extension Router {
    var baseURL: String {
        return "https://api.nasa.gov"
    }

    var baseHeaders: [Headers: String] {
        return headers
    }

    var baseQueryParameters: [QueryParams: String] {
        queryParameters
    }

    var urlRequest: URLRequest {
        let urlComponents = sortedUrlComponents(from: self)
        return basicUrlRequest(from: self, urlComponents: urlComponents)
    }

    private func sortedUrlComponents(from router: Router) -> URLComponents {
        guard var urlComponents = URLComponents(string: baseURL) else { preconditionFailure("Base url not proper") }

        if !router.path.isEmpty {
            urlComponents.path += (router.path.first != "/" ? "/" + router.path : router.path)
        }

        if !router.baseQueryParameters.isEmpty {
            urlComponents.queryItems = router.baseQueryParameters
                .sorted(by: { $0.0.rawValue < $1.0.rawValue })
                .map { URLQueryItem(name: $0.rawValue, value: $1) }
        }

        return urlComponents
    }

    private func basicUrlRequest(from router: Router, urlComponents: URLComponents) -> URLRequest {
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = router.httpMethod.rawValue
        baseHeaders.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key.rawValue)
        }
        switch router.body {
        case let .json(body):
            urlRequest.httpBody = body.jsonData
        case .none:
            break
        }
        return urlRequest
    }
}
