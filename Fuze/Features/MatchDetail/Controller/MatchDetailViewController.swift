//
//  MatchDetailViewController.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 03/11/22.
//

import UIKit

protocol MatchDetailViewControllerDisplayable: AnyObject {
    func displayMatches(matches: [MatchDetailCellViewModel],
                        leagueName: String,
                        matchDate: String,
                        opponents: Opponents)
    func displayError(error: ServiceError)
}

final class MatchDetailViewController: UIViewController {
    private let matchDetailView: MatchDetailViewLogic
    private let viewModel: MatchDetailViewModelLogic
    private let coordinator: MatchDetailCoordinatorLogic

    init(
        matchDetailView: MatchDetailViewLogic,
        viewModel: MatchDetailViewModelLogic,
        coordinator: MatchDetailCoordinatorLogic
    ) {
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
        view.backgroundColor = .darkBlue
    }
}

extension MatchDetailViewController: MatchDetailViewDelegate {
    func tappedBackButton() {
        coordinator.back()
    }
}

extension MatchDetailViewController: MatchDetailViewControllerDisplayable {
    func displayError(error: ServiceError) {
        showError(errorMessage: error.localizedDescription)
        matchDetailView.stopLoading()
    }

    func displayMatches(
        matches: [MatchDetailCellViewModel],
        leagueName: String,
        matchDate: String,
        opponents: Opponents
    ) {
        DispatchQueue.main.async {
            self.matchDetailView.updateView(
                matches,
                leagueName: leagueName,
                matchDate: matchDate,
                opponents: opponents
            )
        }
    }
}
