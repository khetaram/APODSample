//
//  APODViewModel.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

protocol APODViewOutputContract: AnyObject {
    func loadUI(result: ResourceState<APODModelView>)
    func showDatePickerWith(currentDate: Date)
}

class APODViewModel {
    private let realmManager = RealmManager.shared
    private let defaultsManager = UserDefaultManager.shared
    private let service = APODService()
    private var model: APODModel!

    weak var output: APODViewOutputContract?
    private var currentDate: Date

    init() {
        let lastViewedStringDate: String? = defaultsManager.get(.apodLastViewedDate)
        currentDate = lastViewedStringDate?.dateWith(format: AppConfig.apodDateFormat) ?? Date()
    }

    private func loadData(forDate date: Date) {
        if let data: APODModelRealm = realmManager.getObject(forId: date.stringWith(format: AppConfig.apodDateFormat)) {
            model = data.model
            defaultsManager.save(data.model.date, forKey: .apodLastViewedDate)
            output?.loadUI(result: .success(data: APODModelView(from: data.model)))
            return
        }

        service.getPicOfTheDays(date: date, result: { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch res {
                case .loading:
                    self.output?.loadUI(result: .loading)
                case let .error(error):
                    self.output?.loadUI(result: .error(error))
                case let .success(data):
                    self.currentDate = date
                    self.defaultsManager.save(data.date, forKey: .apodLastViewedDate)
                    self.realmManager.insertObject(APODModelRealm(model: data))
                    self.model = data
                    self.output?.loadUI(result: .success(data: APODModelView(from: data)))
                }
            }})
    }

    // MARK: - Inputs contracts
    func viewWillAppear() {
        loadData(forDate: currentDate)
    }

    func favoriteButtonTapped(isFavorite: Bool) {
        model.isFavorite = isFavorite
        realmManager.insertObject(APODModelRealm(model: model))
    }

    func changeDateTapped() {
        output?.showDatePickerWith(currentDate: currentDate)
    }

    func dateChanged(date: Date) {
        loadData(forDate: date)
    }
}
