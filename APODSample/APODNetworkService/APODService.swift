//
//  APODService.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Foundation

class APODService {
    let networkService = NetworkService()

    func getPicOfTheDays(date: Date?, result: @escaping(ResourceState<APODModel>) -> Void ) {
        networkService.request(request: APODRouter.getPicOfTheDay(date: date ?? Date()), result: result)
    }
}
