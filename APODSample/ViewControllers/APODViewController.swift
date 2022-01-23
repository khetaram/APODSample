//
//  ViewController.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 22/01/22.
//

import Cartography

class APODViewController: UIViewController, APODViewOutputContract {
    private let viewModel = APODViewModel()

    @IBOutlet private var contentView: UIView!

    private let apodView = APODView()
    private let infoView = InfoView()
    private let datePickerView = DatePickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.output = self
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    private func setupUI() {
        navigationItem.title = "Pic of the Day"
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(apodView)
        stackView.addArrangedSubview(infoView)
        contentView.addSubview(stackView)

        datePickerView.layer.cornerRadius = 16
        view.addSubview(datePickerView)

        constrain(stackView, datePickerView, contentView, view) { stackView, datePickerView, contentView, view in
            stackView.edges == contentView.edgesWithinMargins.inseted(by: 16)

            datePickerView.leading == view.leadingMargin
            datePickerView.trailing == view.trailingMargin
            datePickerView.top == view.topMargin
        }
    }

    // MARK: - Outputs contracts
    func loadUI(result: ResourceState<APODModelView>) {
        datePickerView.isHidden = true
        switch result {
        case .loading:
            infoView.bindData(text: "Loading data...", viewType: .info)
            apodView.isHidden = true
            infoView.isHidden = false
        case let .error(error):
            infoView.bindData(text: error.localizedDescription, viewType: .error)
            apodView.isHidden = true
            infoView.isHidden = false
        case let .success(data):
            var model = data
            model.favButtonTapped = { [weak self] isFav in
                guard let self = self else { return }
                self.viewModel.favoriteButtonTapped(isFavorite: isFav)
            }
            apodView.bindData(model: model)
            apodView.isHidden = false
            infoView.isHidden = true
        }
    }

    func showDatePickerWith(currentDate: Date) {
        datePickerView.bindDate(model: .init(date: currentDate, donePressed: { [weak self] date in
            guard let self = self else { return }
            self.viewModel.dateChanged(date: date)
            self.datePickerView.isHidden = true
        }))
        datePickerView.isHidden = false
    }

    // MARK: - IBActions
    @IBAction func changeDateTapped(_ sender: Any) {
        viewModel.changeDateTapped()
    }

    func showDataForDate(date: Date) {
        viewModel.dateChanged(date: date)
    }
}
