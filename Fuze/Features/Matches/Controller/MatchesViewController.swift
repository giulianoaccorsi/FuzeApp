//
//  ViewController.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 31/10/22.
//

import UIKit

protocol MatchesViewControllerDisplayable: AnyObject {
    func displayMatches(matches: [MatchCellViewModel])
    func displayError(error: ServiceError)
    func displayMoreMatches(matches: [MatchCellViewModel])
}

class MatchesViewController: UIViewController {
    private let matchesView: MatchesViewProtocol
    private let viewModel: MatchesViewModel
    private let coordinator: MatchesCoordinator

    init(matchesView: MatchesViewProtocol,
         viewModel: MatchesViewModel,
         coordinator: MatchesCoordinator) {
        self.matchesView = matchesView
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = matchesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        matchesView.delegate = self
        viewModel.loadRunningMatches()
    }

    private func setupUI() {
        view.backgroundColor = .backgroundViewColor
        self.title = "Partidas"
    }
}

extension MatchesViewController: MatchesViewControllerDisplayable {
    func displayMoreMatches(matches: [MatchCellViewModel]) {
        matchesView.loadMoreMatches(matches)
    }

    func displayError(error: ServiceError) {
    }

    func displayMatches(matches: [MatchCellViewModel]) {
        matchesView.updateMatches(matches)
    }
}

extension MatchesViewController: MatchesViewDelegate {
    func loadMoreMatches() {
        viewModel.loadMoreMatches()
    }

    func didTappedMatch(match: MatchCellViewModel) {
        coordinator.tappedDetail(match: match)
    }
}
