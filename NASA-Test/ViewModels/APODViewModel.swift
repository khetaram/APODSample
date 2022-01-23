//
//  APODViewModel.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Foundation

protocol APODViewOutputContract: AnyObject {
    func loadUI(result: ResourceState<APODModelView>)
    func showDatePickerWith(currentDate: Date)
}

class APODViewModel {
    private let service = APODService()
    private var model: APODModel!

    weak var output: APODViewOutputContract?
    private var currentDate: Date

    init() {
        let lastViewedStringDate: String? = UserDefaultManager.shared.get(.apodLastViewedDate)
        currentDate = lastViewedStringDate?.dateWith(format: AppConfig.apodDateFormat) ?? Date()
    }

    private func loadData() {
        if let data: APODModelRealm = StorageManager.shared.getObject(forId: currentDate.stringWith(format: AppConfig.apodDateFormat)) {
            model = data.model
            UserDefaultManager.shared.save(data.model.date, forKey: .apodLastViewedDate)
            output?.loadUI(result: .success(data: APODModelView(from: data.model)))
            return
        }

        service.getPicOfTheDays(date: currentDate, result: { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch res {
                case .loading:
                    self.output?.loadUI(result: .loading)
                case let .error(error):
                    self.output?.loadUI(result: .error(error))
                case let .success(data):
                    UserDefaultManager.shared.save(data.date, forKey: .apodLastViewedDate)
                    StorageManager.shared.insertObject(APODModelRealm(model: data))
                    self.model = data
                    self.output?.loadUI(result: .success(data: APODModelView(from: data)))
                }
            }})
    }

    // MARK: - Inputs contracts
    func viewWillAppear() {
        loadData()
    }

    func favoriteButtonTapped(isFavorite: Bool) {
        model.isFavorite = isFavorite
        StorageManager.shared.insertObject(APODModelRealm(model: model))
    }

    func changeDateTapped() {
        output?.showDatePickerWith(currentDate: currentDate)
    }

    func dateChanged(date: Date) {
        currentDate = date
        loadData()
    }
}
