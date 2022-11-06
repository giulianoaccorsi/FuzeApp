//
//  MatchDetailViewController.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit

protocol MatchDetailViewControllerDisplayable: AnyObject {
    func displayMatches(matches: [MatchDetailCellViewModel], leagueName: String, matchDate: String, opponents: OpponentsViewModel)
    func displayError(error: ServiceError)
}

class MatchDetailViewController: UIViewController {
    private let matchDetailView: MatchDetailViewProtocol
    private let viewModel: MatchDetailViewModel
    private let coordinator: MatchDetailCoordinator

    init(matchDetailView: MatchDetailViewProtocol,
         viewModel: MatchDetailViewModel,
         coordinator: MatchDetailCoordinator) {
        self.matchDetailView = matchDetailView
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = matchDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        matchDetailView.delegate = self
        viewModel.loadPlayers()
    }

    func setupUI() {
        view.backgroundColor = .backgroundViewColor
    }
}

extension MatchDetailViewController: MatchDetailViewDelegate {
    func tappedBackButton() {
        coordinator.back()
    }

}

extension MatchDetailViewController: MatchDetailViewControllerDisplayable {
    func displayError(error: ServiceError) {
        //
    }

    func displayMatches(matches: [MatchDetailCellViewModel], leagueName: String, matchDate: String, opponents: OpponentsViewModel) {
        DispatchQueue.main.async {
            self.matchDetailView.updateView(matches, leagueName: leagueName, matchDate: matchDate, opponents: opponents)
        }
    }
}
