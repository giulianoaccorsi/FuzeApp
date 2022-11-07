//
//  MatchDetailView.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

protocol MatchDetailViewLogic: UIView {
    var delegate: MatchDetailViewDelegate? { get set }
    func updateView(_ matches: [MatchDetailCellViewModel],
                    leagueName: String,
                    matchDate: String,
                    opponents: Opponents)
    func stopLoading()
}

protocol MatchDetailViewDelegate: AnyObject {
    func tappedBackButton()
}

final class MatchDetailView: UIView, MatchDetailViewLogic {
    var delegate: MatchDetailViewDelegate?

    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.startAnimating()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let matchName: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.numberOfLines = 2
        label.font = .robotoMedium18
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let opponentsView: OpponentsView = {
        let view = OpponentsView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let dateName: UILabel = {
        let label = UILabel()
        label.textColor = .labels
        label.font = .robotoBold12
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var dataSource = MatchDetailDataSource()

    init() {
        super.init(frame: .zero)
        dataSource.setupTableView(tableView: tableView)
        backButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(
        _ matches: [MatchDetailCellViewModel],
        leagueName: String,
        matchDate: String,
        opponents: Opponents
    ) {
        dateName.text = matchDate
        opponentsView.configureViewWith(opponents)
        matchName.text = leagueName
        dataSource.players = matches
        showUI()
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }

    @objc
    private func tappedButton() {
        delegate?.tappedBackButton()
    }

    private func showUI() {
        indicatorView.stopAnimating()
        opponentsView.isHidden = false
        dateName.isHidden = false
        tableView.isHidden = false

    }

    private func buildViewHierarchy() {
        addSubview(indicatorView)
        addSubview(backButton)
        addSubview(matchName)
        addSubview(opponentsView)
        addSubview(dateName)
        addSubview(tableView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .spacing34),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacing28),
            backButton.widthAnchor.constraint(equalToConstant: .spacing40),
            backButton.heightAnchor.constraint(equalToConstant: .spacing40),

            matchName.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            matchName.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: .spacing16),
            matchName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacing8),

            opponentsView.topAnchor.constraint(equalTo: matchName.bottomAnchor, constant: .spacing24),
            opponentsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            opponentsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacing92),
            opponentsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacing92),

            dateName.topAnchor.constraint(equalTo: opponentsView.bottomAnchor, constant: .spacing20),
            dateName.centerXAnchor.constraint(equalTo: opponentsView.centerXAnchor),

            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: dateName.bottomAnchor, constant: .spacing24),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setUpAdditionalConfiguration() {
        tableView.backgroundColor = .clear
    }
}
