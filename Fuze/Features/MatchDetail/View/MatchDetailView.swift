//
//  MatchDetailView.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

protocol MatchDetailViewProtocol: UIView {
    var delegate: MatchDetailViewDelegate? { get set }
    func updateView(_ matches: [MatchDetailCellViewModel],
                    leagueName: String,
                    matchDate: String,
                    opponents: OpponentsViewModel)
}

protocol MatchDetailViewDelegate: AnyObject {
    func tappedBackButton()
}

final class MatchDetailView: UIView, MatchDetailViewProtocol {

    var delegate: MatchDetailViewDelegate?

    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
      view.color = .white
      view.startAnimating()
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
        label.textColor = .title
        label.numberOfLines = 2
        label.font = .matchNameDetail
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
        label.textColor = .title
        label.font = .matchDateDetail
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

    func updateView(_ matches: [MatchDetailCellViewModel],
                    leagueName: String,
                    matchDate: String,
                    opponents: OpponentsViewModel) {
        dateName.text = matchDate
        opponentsView.configureView(with: opponents)
        matchName.text = leagueName
        dataSource.players = matches
        showUI()
    }

    @objc private func tappedButton() {
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

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 34),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            matchName.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            matchName.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16),
            matchName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            opponentsView.topAnchor.constraint(equalTo: matchName.bottomAnchor, constant: 24),
            opponentsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            opponentsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 93),
            opponentsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -93),

            dateName.topAnchor.constraint(equalTo: opponentsView.bottomAnchor, constant: 20),
            dateName.centerXAnchor.constraint(equalTo: opponentsView.centerXAnchor),

            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: dateName.bottomAnchor, constant: 24),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setUpAdditionalConfiguration() {
        tableView.backgroundColor = .clear
    }
}
