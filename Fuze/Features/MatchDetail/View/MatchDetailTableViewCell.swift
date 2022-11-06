//
//  MatchDetailTableViewCell.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit
import Kingfisher

final class MatchDetailTableViewCell: UITableViewCell {
    private let backgroundFirstView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .backgroundViewCornerRadius
        view.backgroundColor = .backgroundCell
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let namePlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .nameCellLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let nickPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.textAlignment = .center
        label.font = .nickCellLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let playerImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = .imageViewPlayerCellCornerRadius
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let backgroundSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCell
        view.layer.cornerRadius = .backgroundViewCornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let nameSecondPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .nameCellLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let nickSecondPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.textAlignment = .center
        label.font = .nickCellLabel
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let playerSecondImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = .imageViewPlayerCellCornerRadius
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backgroundFirstView, backgroundSecondView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .horizontalCellDetailSpacing
        stack.distribution = .fillEqually

        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MatchDetailCellViewModel) {
        nickPlayerLabel.text = viewModel.nickPlayerLabel
        namePlayerLabel.text = viewModel.namePlayerLabel
        playerImageView.kf.setImage(with: viewModel.playerImageView, placeholder: viewModel.placeHolder)


        playerSecondImageView.kf.setImage(with: viewModel.playerSecondImageView, placeholder: viewModel.placeHolder)
        nickSecondPlayerLabel.text = viewModel.nickSecondPlayerLabel
        nameSecondPlayerLabel.text = viewModel.nameSecondPlayerLabel
    }

    private func buildViewHierarchy() {
        contentView.addSubview(stackView)
        backgroundFirstView.addSubview(playerImageView)
        backgroundFirstView.addSubview(nickPlayerLabel)
        backgroundFirstView.addSubview(namePlayerLabel)

        backgroundSecondView.addSubview(playerSecondImageView)
        backgroundSecondView.addSubview(nickSecondPlayerLabel)
        backgroundSecondView.addSubview(nameSecondPlayerLabel)
    }

    private func setUpConstraints() {

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            playerImageView.widthAnchor.constraint(equalToConstant: 50),
            playerImageView.heightAnchor.constraint(equalToConstant: 50),
            playerImageView.topAnchor.constraint(equalTo: backgroundFirstView.topAnchor),
            playerImageView.trailingAnchor.constraint(equalTo: backgroundFirstView.trailingAnchor, constant: -12),

            nickPlayerLabel.centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor),
            nickPlayerLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -16),
            nickPlayerLabel.leadingAnchor.constraint(equalTo: backgroundFirstView.leadingAnchor, constant: 4),

            namePlayerLabel.topAnchor.constraint(equalTo: nickPlayerLabel.bottomAnchor, constant: 8),
            namePlayerLabel.bottomAnchor.constraint(equalTo: backgroundFirstView.bottomAnchor, constant: -8),
            namePlayerLabel.trailingAnchor.constraint(equalTo: nickPlayerLabel.trailingAnchor),
            namePlayerLabel.leadingAnchor.constraint(equalTo: nickPlayerLabel.leadingAnchor),

            playerSecondImageView.widthAnchor.constraint(equalToConstant: 50),
            playerSecondImageView.heightAnchor.constraint(equalToConstant: 50),
            playerSecondImageView.topAnchor.constraint(equalTo: backgroundSecondView.topAnchor),
            playerSecondImageView.leadingAnchor.constraint(equalTo: backgroundSecondView.leadingAnchor, constant: 12),

            nickSecondPlayerLabel.centerYAnchor.constraint(equalTo: playerSecondImageView.centerYAnchor),
            nickSecondPlayerLabel.leadingAnchor.constraint(equalTo: playerSecondImageView.trailingAnchor, constant: 16),
            nickSecondPlayerLabel.trailingAnchor.constraint(equalTo: backgroundSecondView.trailingAnchor, constant: -4),

            nameSecondPlayerLabel.topAnchor.constraint(equalTo: nickSecondPlayerLabel.bottomAnchor, constant: 8),
            nameSecondPlayerLabel.trailingAnchor.constraint(equalTo: nickSecondPlayerLabel.trailingAnchor),
            nameSecondPlayerLabel.leadingAnchor.constraint(equalTo: nickSecondPlayerLabel.leadingAnchor),
            nameSecondPlayerLabel.bottomAnchor.constraint(equalTo: backgroundSecondView.bottomAnchor, constant: -8),

        ])
    }

    private func setUpAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
