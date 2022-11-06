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
        label.textColor = .title
        label.font = .title
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2

        return label
    }()

    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .title
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2

        return label
    }()

    private lazy var firstTeamStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstTeamImage, firstTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .verticalTeamSpacing
        stack.distribution = .fillEqually

        return stack
    }()

    private let versusLabel: UILabel = {
        let label = UILabel()
        label.text = "vs"
        label.textColor = .versus
        label.font = .versus

        return label
    }()

    private lazy var secondTeamStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secondTeamImage, secondTeamLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = .verticalTeamSpacing
        stack.distribution = .fillEqually

        return stack
    }()
    
    private lazy var opponentsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstTeamStack, versusLabel, secondTeamStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = .horizontalOpponenSpacing
        stack.distribution = .equalCentering

        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViewHierarchy()
        setUpConstraints()
    }

    func configureView(with viewModel: OpponentsViewModel) {
        let firstTeamImageURL = URL(string: viewModel.firstTeamImage)
        let secondTeamImageURL = URL(string: viewModel.secondTeamImage)
        firstTeamImage.kf.setImage(with: firstTeamImageURL, placeholder: UIImage(named: "placeholder"))
        secondTeamImage.kf.setImage(with: secondTeamImageURL, placeholder: UIImage(named: "placeholder"))

        firstTeamLabel.text = viewModel.firstTeamLabel
        secondTeamLabel.text = viewModel.secondTeamLabel
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

            firstTeamImage.widthAnchor.constraint(equalToConstant: .widthTeamImage),
            firstTeamImage.heightAnchor.constraint(equalToConstant: .heightTeamImage),

            secondTeamImage.widthAnchor.constraint(equalToConstant: .widthTeamImage),
            secondTeamImage.heightAnchor.constraint(equalToConstant: .heightTeamImage),
        ])
    }
}
