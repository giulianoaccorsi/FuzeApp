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
        divisor.backgroundColor = .white.withAlphaComponent(0.2)
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
        label.textColor = .labels
        label.font = .robotoRegular8
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
        view.layer.cornerRadius = .spacing16
        view.clipsToBounds = true
        view.backgroundColor = .lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let opponentsView: OpponentsView = {
        let view = OpponentsView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var leagueStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leagueImageView, matchNameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .spacing8
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
        opponentsView.configureViewWith(viewModel.opponents)
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
            backgroundUIView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .spacing24),
            backgroundUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.spacing24),
            backgroundUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .spacing24),
            backgroundUIView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            leagueStack.bottomAnchor.constraint(equalTo: backgroundUIView.bottomAnchor, constant: -.spacing8),
            leagueStack.leadingAnchor.constraint(equalTo: backgroundUIView.leadingAnchor, constant: .spacing16),
            leagueStack.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor, constant: -.spacing16),

            leagueImageView.widthAnchor.constraint(equalToConstant: .spacing16),
            leagueImageView.heightAnchor.constraint(equalToConstant: .spacing16),

            matchNameLabel.centerYAnchor.constraint(equalTo: leagueImageView.centerYAnchor),

            divisorUIView.leadingAnchor.constraint(equalTo: backgroundUIView.leadingAnchor),
            divisorUIView.trailingAnchor.constraint(equalTo: backgroundUIView.trailingAnchor),
            divisorUIView.heightAnchor.constraint(equalToConstant: .spacing1),
            divisorUIView.bottomAnchor.constraint(equalTo: leagueStack.topAnchor, constant: -.spacing8),

            opponentsView.bottomAnchor.constraint(equalTo: divisorUIView.topAnchor, constant: -.spacing16),
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
