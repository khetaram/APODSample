//
//  APODTableViewCell.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import UIKit

class APODTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var favButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var apodImageView: UIImageView!

    var model: APODModelView?

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = AppColor.lightText
        dateLabel.font = .systemFont(ofSize: 21, weight: .bold)

        titleLabel.textColor = AppColor.lightText
        apodImageView.kf.indicatorType = .activity

        imageView?.contentMode = .scaleAspectFit
    }

    func bindData(model: APODModelView) {
        self.model = model
        self.dateLabel.text = model.date
        self.titleLabel.text = model.title
        self.apodImageView.kf.setImage(with: URL(string: model.url)!)
        favButton.setImage(UIImage(named: "favorite")!, for: .selected)
        favButton.setImage(UIImage(named: "unFavorite")!, for: .normal)
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        favButton.isSelected = model.isFavorite
    }

    @IBAction private func favButtonTapped(_ sender: Any) {
        favButton.isSelected = !favButton.isSelected
        model?.favButtonTapped?(favButton.isSelected)
    }
}
