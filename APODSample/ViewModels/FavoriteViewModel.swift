//
//  FavoriteViewModel.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

protocol FavoriteViewOutputContract: AnyObject {
    func showEmptyListUI(show: Bool)
    func reloadData()
}

class FavoriteViewModel {
    weak var output: FavoriteViewOutputContract?

    private let realmManager = RealmManager.shared
    var favoriteList = [APODModel]()

    func viewWillAppear() {
        getFavoriteList()
    }

    func favoriteButtonTapped(isFavorite: Bool, index: Int) {
        var model = self.favoriteList[index]
        model.isFavorite = isFavorite
        realmManager.insertObject( APODModelRealm(model: model) )
        self.getFavoriteList()
    }

    private func getFavoriteList() {
        let modelList: [APODModelRealm] = realmManager.getObjects()
         favoriteList = modelList.map { $0.model }
            .filter { $0.isFavorite == true }
        output?.showEmptyListUI(show: favoriteList.isEmpty)
        output?.reloadData()
    }
}
