//
//  MatchDetailDataSource.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit

final class MatchDetailDataSource: NSObject {
    private var tableView: UITableView?

    var players: [MatchDetailCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }

    func setupTableView(tableView: UITableView) {
        self.tableView = tableView
        registerCell()
        setupDataSource()
    }

    private func registerCell() {
        self.tableView?.register(MatchDetailTableViewCell.self, forCellReuseIdentifier: MatchDetailTableViewCell.description())
    }

    private func setupDataSource() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
}

extension MatchDetailDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MatchDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: MatchDetailTableViewCell.description(), for: indexPath) as? MatchDetailTableViewCell else { return UITableViewCell() }
        cell.configure(with: players[indexPath.row])

        return cell
    }
}

