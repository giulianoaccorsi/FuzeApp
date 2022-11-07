//
//  OpponentsView.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

final class OpponentsView: UIView {
    private let firstTeamImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit

        return image
    }()

    private let secondTeamImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.font = .robotoRegular10
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2

        return label
    }()

    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.font = .robotoRegular10
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    private lazy var firstTeamStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstTeamImage, firstTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .spacing12
        stack.distribution = .fillEqually

        return stack
    }()

    private let versusLabel: UILabel = {
        let label = UILabel()
        label.text = "vs"
        label.textColor = .grayColor
        label.font = .robotoRegular12

        return label
    }()

    private lazy var secondTeamStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secondTeamImage, secondTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .spacing12
        stack.distribution = .fillEqually

        return stack
    }()
    
    private lazy var opponentsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstTeamStack, versusLabel, secondTeamStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .spacing24
        stack.distribution = .equalCentering

        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setUpConstraints()
    }

    func configureViewWith(_ opponent: Opponents) {
        let firstTeamImageURL = URL(string: opponent.firstTeamImage)
        let secondTeamImageURL = URL(string: opponent.secondTeamImage)
        firstTeamImage.kf.setImage(with: firstTeamImageURL, placeholder: UIImage(named: "placeholder"))
        secondTeamImage.kf.setImage(with: secondTeamImageURL, placeholder: UIImage(named: "placeholder"))

        firstTeamLabel.text = opponent.firstTeamLabel
        secondTeamLabel.text = opponent.secondTeamLabel
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViewHierarchy() {
        addSubview(opponentsStack)
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            opponentsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            opponentsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            opponentsStack.topAnchor.constraint(equalTo: topAnchor),
            opponentsStack.bottomAnchor.constraint(equalTo: bottomAnchor),

            firstTeamImage.widthAnchor.constraint(equalToConstant: .spacing60),
            firstTeamImage.heightAnchor.constraint(equalToConstant: .spacing60),

            secondTeamImage.widthAnchor.constraint(equalToConstant: .spacing60),
            secondTeamImage.heightAnchor.constraint(equalToConstant: .spacing60),
        ])
    }
}
