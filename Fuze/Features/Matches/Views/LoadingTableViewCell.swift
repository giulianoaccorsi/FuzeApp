//
//  LoadingTableViewCell.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
      view.color = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }

    func startLoading() {
        indicatorView.startAnimating()
    }

    func stopLoading() {
        indicatorView.stopAnimating()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildViewHierarchy() {
        contentView.addSubview(indicatorView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    private func setUpAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
