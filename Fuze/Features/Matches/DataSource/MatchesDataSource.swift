//
//  MatchesDataSource.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import UIKit

enum SectionItems: Int {
    case matches = 0
    case loading = 1
}

protocol MatchesDataSourceDelegate: AnyObject {
    func didTappedMatch(matchDetail: MatchDetail)
    func loadMoreData()
}

final class MatchesDataSource: NSObject {
    var runningMatches: [MatchCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }

    private var tableView: UITableView?
    weak var delegate: MatchesDataSourceDelegate?
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
        case SectionItems.matches.rawValue:
            return runningMatches.count
        case SectionItems.loading.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SectionItems.matches.rawValue {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionItems.matches.rawValue {
            let match = runningMatches[indexPath.row]
            let matchDetail = MatchDetail(
                firstTeamID: match.firstTeamID,
                secondTeamID: match.secondTeamID,
                matchName: match.matchName,
                dateName: match.matchDate,
                opponents: Opponents(
                    firstTeamImage: match.opponents.firstTeamImage,
                    firstTeamLabel: match.opponents.firstTeamLabel,
                    secondTeamImage: match.opponents.secondTeamImage,
                    secondTeamLabel: match.opponents.secondTeamLabel
                )
            )
            delegate?.didTappedMatch(matchDetail: matchDetail)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItems = 10
        if indexPath.row == runningMatches.count - lastItems {
            delegate?.loadMoreData()
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == SectionItems.loading.rawValue {
            return nil
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 80
        }
        return tableView.rowHeight
    }
}

