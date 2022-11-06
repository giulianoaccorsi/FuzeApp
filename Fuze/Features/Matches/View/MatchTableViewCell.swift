//
//  MatchTableViewCell.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 01/11/22.
//

import UIKit
import Kingfisher

final class MatchTableViewCell: UITableViewCell {
    private let divisorUIView: UIView = {
        let divisor = UIView()
        divisor.backgroundColor = .divisorView
        divisor.translatesAutoresizingMaskIntoConstraints = false

        return divisor
    }()

    private let leagueImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit

        return image
    }()

    private let matchNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .league
        label.font = .league
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    private let dateView: DateView = {
        let view = DateView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let backgroundUIView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .backgroundViewCornerRadius
        view.clipsToBounds = true
        view.backgroundColor = .backgroundCell
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var opponentsView: OpponentsView = {
        let view = OpponentsView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var leagueStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leagueImageView, matchNameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .horizontalLeagueSpacing
        stack.alignment = .leading

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

    func configure(with viewModel: MatchCellViewModel) {
        leagueImageView.kf.setImage(with: viewModel.leagueImageUrl, placeholder: viewModel.imagePlaceHolder)
        opponentsView.configureView(with: viewModel.opponentViewModel)
        matchNameLabel.text = viewModel.matchName
        dateView.configure(with: viewModel.status, text: viewModel.matchDate)
    }

    private func buildViewHierarchy() {
        contentView.addSubview(backgroundUIView)
        backgroundUIView.addSubview(leagueStack)
        backgroundUIView.addSubview(divisorUIView)
        backgroundUIView.addSubview(opponentsView)
        backgroundUIView.addSubview(dateView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .horizontalLarge),
            backgroundUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.horizontalLarge),
            backgroundUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .verticalLarge),
            backgroundUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            leagueStack.bottomAnchor.constraint(equalTo: backgroundUIView.bottomAnchor, constant: -.verticalSmall),
            leagueStack.leadingAnchor.constraint(equalTo: backgroundUIView.leadingAnchor, constant: .horizontal),
            leagueStack.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor, constant: -.horizontal),

            leagueImageView.widthAnchor.constraint(equalToConstant: .widthLeagueImage),
            leagueImageView.heightAnchor.constraint(equalToConstant: .heightLeagueImage),

            matchNameLabel.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor),

            divisorUIView.leadingAnchor.constraint(equalTo: backgroundUIView.leadingAnchor),
            divisorUIView.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor),
            divisorUIView.heightAnchor.constraint(equalToConstant: .divisorHeight),
            divisorUIView.bottomAnchor.constraint(equalTo: leagueStack.topAnchor, constant: -.verticalSmall),

            opponentsView.bottomAnchor.constraint(equalTo: divisorUIView.topAnchor, constant: -.vertical),
            opponentsView.centerYAnchor.constraint(equalTo: backgroundUIView.centerYAnchor),
            opponentsView.centerXAnchor.constraint(equalTo: backgroundUIView.centerXAnchor),

            dateView.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: backgroundUIView.topAnchor)
        ])
    }

    private func setUpAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
