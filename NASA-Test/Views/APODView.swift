//
//  APODView.swift
//  NASA-Test
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import UIKit
import Cartography
import Kingfisher

struct APODModelView {
    let title: String
    let explanation: String
    let date: String
    let url: String
    let hdUrl: String?
    let mediaType: MediaType
    let isFavorite: Bool

    var favButtonTapped: ((_ isSelected: Bool) -> Void)?

    init(from model: APODModel) {
        self.title = model.title
        self.explanation = model.explanation
        self.date = model.date
        self.url = model.url
        self.hdUrl = model.hdUrl
        self.mediaType = model.mediaType
        self.isFavorite = model.isFavorite ?? false
    }

}
class APODView: UIView {
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let expalanationLabel = UILabel()
    private let imageView = UIImageView()
    private let favButton = UIButton()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        addSubview(stackView)

        dateLabel.font = .systemFont(ofSize: 21, weight: .bold)
        dateLabel.textColor = AppColor.lightText
        stackView.addArrangedSubview(dateLabel)

        titleLabel.numberOfLines = 0
        titleLabel.textColor = AppColor.lightText
        stackView.addArrangedSubview(titleLabel)

        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        stackView.addArrangedSubview(imageView)

        expalanationLabel.numberOfLines = 0
        expalanationLabel.textColor = AppColor.lightText
        stackView.addArrangedSubview(expalanationLabel)

        constrain(stackView, imageView, self) { stackView, imageView, containerView in
            stackView.edges == inset(containerView.edges, 16)
            imageView.height == 200
        }

        favButton.setImage(UIImage(named: "favorite")!, for: .selected)
        favButton.setImage(UIImage(named: "unFavorite")!, for: .normal)
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        addSubview(favButton)
        constrain(favButton, self) { favButton, view in
            favButton.top == view.top
            favButton.trailing == view.trailingMargin
            favButton.height == favButton.width
            favButton.height == 40
        }
    }

    func bindData(model: APODModelView) {
        self.model = model
        dateLabel.text = model.date
        titleLabel.text = model.title
        imageView.kf.setImage(with: URL(string: model.url)!)
        expalanationLabel.text = model.explanation
        favButton.isSelected = model.isFavorite
    }

    var model: APODModelView?
    @objc func favButtonTapped() {
        favButton.isSelected = !favButton.isSelected
        model?.favButtonTapped?(favButton.isSelected)
    }
}
