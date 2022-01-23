//
//  NetworkService.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import UIKit

class NetworkService {
    var dataTask: URLSessionDataTask?

    func request<T: Decodable>(request: Router, result: @escaping(ResourceState<T>)-> Void) {
        result(.loading)

        dataTask = URLSession.shared.dataTask(with: request.urlRequest, completionHandler: { [weak self] (data, response, error) in
            guard let _ = self else { return }
            if let error = error {
                result(.error(error))
                return
            }
            guard let data = data else {
                result(.error(AppError.nullResponseData))
                return
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {

                guard let response = try? decoder.decode(APIError.self, from: data) else {
                    result(.error(AppError.jsonParseError))
                    return
                }
                result(.error(response))
                return
            }
            result(.success(data: response))
        })

        dataTask?.resume()
    }
}
