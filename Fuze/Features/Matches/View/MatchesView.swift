//
//  MatchesView.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import UIKit

protocol MatchesViewProtocol: UIView {
    var delegate: MatchesViewDelegate? { get set }
    func updateMatches(_ matches: [MatchCellViewModel])
    func loadMoreMatches(_ matches: [MatchCellViewModel])
}

protocol MatchesViewDelegate: AnyObject {
    func didTappedMatch(match: MatchCellViewModel)
    func loadMoreMatches()
}

final class MatchesView: UIView, MatchesViewProtocol {
    weak var delegate: MatchesViewDelegate?

    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
      view.color = .white
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var dataSource = MatchesDataSource()
   
    init() {
        super.init(frame: .zero)
        dataSource.delegate = self
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateMatches(_ matches: [MatchCellViewModel]) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
        dataSource.runningMatches = matches
    }

    func loadMoreMatches(_ matches: [MatchCellViewModel]) {
        dataSource.runningMatches.append(contentsOf: matches)
        dataSource.isLoading = false
    }

    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(indicatorView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),

            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func setUpAdditionalConfiguration() {
        tableView.backgroundColor = .clear
        dataSource.setupTableView(tableView: tableView)
    }
}

extension MatchesView: MatchesDataSourceDelegate {
    func loadMoreData() {
        delegate?.loadMoreMatches()
        dataSource.isLoading = true
    }

    func didTappedMatch(match: MatchCellViewModel) {
        delegate?.didTappedMatch(match: match)
    }
}
