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
        view.layer.cornerRadius = .spacing16
        view.backgroundColor = .lightBlue
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let namePlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .robotoRegular12
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let nickPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.textAlignment = .center
        label.font = .robotoBold14
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let playerImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = .spacing8
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let backgroundSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.layer.cornerRadius = .spacing16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let nameSecondPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .robotoRegular12
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let nickSecondPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.textAlignment = .center
        label.font = .robotoBold14
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let playerSecondImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = .spacing8
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backgroundFirstView, backgroundSecondView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .spacing12
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
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.spacing16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            playerImageView.widthAnchor.constraint(equalToConstant: .spacing50),
            playerImageView.heightAnchor.constraint(equalToConstant: .spacing50),
            playerImageView.topAnchor.constraint(equalTo: backgroundFirstView.topAnchor),
            playerImageView.trailingAnchor.constraint(equalTo: backgroundFirstView.trailingAnchor, constant: -.spacing12),

            nickPlayerLabel.centerYAnchor.constraint(equalTo: playerImageView.centerYAnchor),
            nickPlayerLabel.trailingAnchor.constraint(equalTo: playerImageView.leadingAnchor, constant: -.spacing16),
            nickPlayerLabel.leadingAnchor.constraint(equalTo: backgroundFirstView.leadingAnchor, constant: .spacing4),

            namePlayerLabel.topAnchor.constraint(equalTo: nickPlayerLabel.bottomAnchor, constant: .spacing8),
            namePlayerLabel.bottomAnchor.constraint(equalTo: backgroundFirstView.bottomAnchor, constant: -.spacing8),
            namePlayerLabel.trailingAnchor.constraint(equalTo: nickPlayerLabel.trailingAnchor),
            namePlayerLabel.leadingAnchor.constraint(equalTo: nickPlayerLabel.leadingAnchor),

            playerSecondImageView.widthAnchor.constraint(equalToConstant: .spacing50),
            playerSecondImageView.heightAnchor.constraint(equalToConstant: .spacing50),
            playerSecondImageView.topAnchor.constraint(equalTo: backgroundSecondView.topAnchor),
            playerSecondImageView.leadingAnchor.constraint(equalTo: backgroundSecondView.leadingAnchor, constant: .spacing12),

            nickSecondPlayerLabel.centerYAnchor.constraint(equalTo: playerSecondImageView.centerYAnchor),
            nickSecondPlayerLabel.leadingAnchor.constraint(equalTo: playerSecondImageView.trailingAnchor, constant: .spacing16),
            nickSecondPlayerLabel.trailingAnchor.constraint(equalTo: backgroundSecondView.trailingAnchor, constant: -.spacing4),

            nameSecondPlayerLabel.topAnchor.constraint(equalTo: nickSecondPlayerLabel.bottomAnchor, constant: .spacing8),
            nameSecondPlayerLabel.trailingAnchor.constraint(equalTo: nickSecondPlayerLabel.trailingAnchor),
            nameSecondPlayerLabel.leadingAnchor.constraint(equalTo: nickSecondPlayerLabel.leadingAnchor),
            nameSecondPlayerLabel.bottomAnchor.constraint(equalTo: backgroundSecondView.bottomAnchor, constant: -.spacing8),

        ])
    }

    private func setUpAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
