//
//  TypeView.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 01/11/22.
//

import UIKit

enum TypeView: String {
    case running = "running"
    case notStarted = "not_started"
    case other
}

final class DateView: UIView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let dateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .dateView
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with type: TypeView, text: String = "") {
        switch type {
        case .running:
            backgroundView.backgroundColor = .backgroundCellRed
            dateTextLabel.text = .running
        case .notStarted:
            backgroundView.backgroundColor = .backgroundCellGray
            dateTextLabel.text = text
        case .other:
            backgroundView.backgroundColor = .backgroundCellGray
            dateTextLabel.text = text
        }
    }

    private func buildViewHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(dateTextLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            dateTextLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            dateTextLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            dateTextLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor,constant: 8),
            dateTextLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
        ])
    }

    private func setUpAdditionalConfiguration() {
        clipsToBounds = true
    }
}

