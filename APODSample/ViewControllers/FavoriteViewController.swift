//
//  FavoriteViewController.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Cartography

class FavoriteViewController: UIViewController, FavoriteViewOutputContract {
    private let viewModel = FavoriteViewModel()

    private let tableView = UITableView()
    private let emptyListLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.output = self
        viewModel.viewWillAppear()
    }

    private func setupUI() {
        navigationItem.title = "My Favorites"

        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "APODTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "APODTableViewCell")
        view.addSubview(tableView)

        emptyListLabel.textColor = AppColor.lightText
        emptyListLabel.text = "Your favorite list is empty!"
        emptyListLabel.numberOfLines = 0
        emptyListLabel.textAlignment = .center
        tableView.addSubview(emptyListLabel)

        constrain(tableView, emptyListLabel, view) { tableView, emptyListLabel, view in
            tableView.edges == view.edges.inseted(by: 16)

            emptyListLabel.leading == tableView.leading
            emptyListLabel.trailing == tableView.trailing
            emptyListLabel.top == tableView.top + 32
            emptyListLabel.width == tableView.width
        }
    }

    // MARK: - Outputs contracts
    func reloadData() {
        tableView.reloadData()
    }

    func showEmptyListUI(show: Bool) {
        emptyListLabel.isHidden = !show
        tableView.bringSubviewToFront(emptyListLabel)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    // MARK: - TableView datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoriteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "APODTableViewCell") as! APODTableViewCell
        var model = APODModelView(from: viewModel.favoriteList[indexPath.row])
        model.favButtonTapped = { [weak self] isFav in
            guard let self = self else { return }
            self.viewModel.favoriteButtonTapped(isFavorite: isFav, index: indexPath.row)
        }
        cell.bindData(model: model)
        return cell
    }
}
