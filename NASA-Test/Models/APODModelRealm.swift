//
//  APODModelRealm.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import RealmSwift

final class APODModelRealm: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var explanation: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var hdUrl: String = ""
    @objc dynamic var mediaType: String = ""
    @objc dynamic var isFavorited: Bool = false

    var model: APODModel {
        return APODModel(title: title,
                         explanation: explanation,
                         date: date,
                         url: url,
                         hdUrl: hdUrl,
                         mediaType: .init(rawValue: mediaType) ?? .image,
                         isFavorite: isFavorited)
    }

    convenience init(model: APODModel) {
        self.init()
        self.title = model.title
        self.explanation = model.explanation
        self.date = model.date
        self.url = model.url
        self.hdUrl = model.hdUrl ?? ""
        self.mediaType = model.mediaType.rawValue
        self.isFavorited = model.isFavorite ?? false
    }

    override class func primaryKey() -> String? {
        return "date"
    }
}
