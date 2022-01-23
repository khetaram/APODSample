//
//  StorageManager.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

import RealmSwift

class StorageManager {
    static let shared = StorageManager()

    func insertObject<T: Object>(_ object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .all)
        }
    }

    func removeObject<T: Object>(_ id: String, type: T.Type) {
        let realm = try! Realm()
        let object = realm.object(ofType: T.self, forPrimaryKey: id)
        if let object = object {
            try! realm.write {
                realm.delete([object])
            }
        }
    }

    func getObjects<T: Object>() -> [T] {
        let realm = try! Realm()
        let objects = realm.objects(T.self)
        return  objects.map { $0 }
    }

    func getObject<T: Object>(forId id: String) -> T? {
        let realm = try! Realm()
        let object = realm.object(ofType: T.self, forPrimaryKey: id)
        return  object.map { $0 }
    }
}
