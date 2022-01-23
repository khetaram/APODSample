//
//  APODModel.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

enum MediaType: String, Codable {
    case image
    case video
}

struct APODModel: Codable {
    let title: String
    let explanation: String
    let date: String
    let url: String
    let hdUrl: String?
    let mediaType: MediaType
    var isFavorite: Bool? = false

    private enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case date
        case url
        case hdUrl = "hdurl"
        case mediaType = "media_type"
        case isFavorite
    }
}
