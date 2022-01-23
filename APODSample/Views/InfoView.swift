//
//  InfoView.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Cartography

class InfoView: UIView {
    private let textLabel = UILabel()
    private var viewType = ViewType.info

    enum ViewType {
        case info
        case error
    }
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        textLabel.numberOfLines = 0
        textLabel.textColor = AppColor.lightText
        addSubview(textLabel)

        constrain(textLabel, self) { textLabel, containerView in
            textLabel.edges == inset(containerView.edges, 16)
        }
    }

    func bindData(text: String, viewType: ViewType) {
        textLabel.text = text
        switch viewType {
        case .info:
            backgroundColor = AppColor.infoBackground
        case .error:
            backgroundColor = AppColor.errorBackground
        }
    }
}
