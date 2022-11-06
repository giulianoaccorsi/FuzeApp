//
//  MatchesDataSource.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import UIKit

protocol MatchesDataSourceDelegate: AnyObject {
    func didTappedMatch(match: MatchCellViewModel)
    func loadMoreData()
}

final class MatchesDataSource: NSObject {
    private var tableView: UITableView?
    weak var delegate: MatchesDataSourceDelegate?
    
    var runningMatches: [MatchCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }

    var isLoading = false
    
    func setupTableView(tableView: UITableView) {
        self.tableView = tableView
        registerCell()
        setupDataSource()
    }
    
    private func registerCell() {
        self.tableView?.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.description())
        self.tableView?.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.description())
    }
    
    private func setupDataSource() {
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
}

extension MatchesDataSource: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return runningMatches.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell: MatchTableViewCell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.description(), for: indexPath) as? MatchTableViewCell else { return UITableViewCell() }
            cell.configure(with: runningMatches[indexPath.row])

            return cell
        } else {
            guard let cell: LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.description(), for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
            if isLoading {
                cell.startLoading()
            } else {
                cell.stopLoading()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 100
        }else {
            return tableView.rowHeight
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            delegate?.didTappedMatch(match: runningMatches[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == runningMatches.count - 10 {
            delegate?.loadMoreData()
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            return nil
        }
        return indexPath
    }
}

