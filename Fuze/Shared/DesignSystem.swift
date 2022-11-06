//
//  DesignSystem.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 01/11/22.
//

import UIKit

extension CGFloat {
    static let horizontalSmall: CGFloat = 8
    static let horizontal: CGFloat = 16
    static let horizontalLarge: CGFloat = 24

    static let verticalSmall: CGFloat = 8
    static let vertical: CGFloat = 16
    static let verticalLarge: CGFloat = 24

    static let widthLeagueImage: CGFloat = 16
    static let heightLeagueImage: CGFloat = 16

    static let widthTeamImage: CGFloat = 60
    static let heightTeamImage: CGFloat = 60

    static let divisorHeight: CGFloat = 1

    static let backgroundViewCornerRadius: CGFloat = 16
    static let imageViewPlayerCellCornerRadius: CGFloat = 8

    static let verticalTeamSpacing: CGFloat = 10
    static let horizontalOpponenSpacing: CGFloat = 20
    static let horizontalLeagueSpacing:CGFloat = 8
    static let horizontalCellDetailSpacing:CGFloat = 13
}

extension UIFont {
    static let title = UIFont(name: "Roboto-Regular", size: 10)
    static let versus = UIFont(name: "Roboto-Regular", size: 12)
    static let league = UIFont(name: "Roboto-Regular", size: 8)
    static let dateView = UIFont(name: "Roboto-Regular", size: 8)
    static let matchNameDetail = UIFont(name: "Roboto-Medium", size: 18)
    static let matchDateDetail = UIFont(name: "Roboto-Bold", size: 12)
    static let nickCellLabel = UIFont(name: "Roboto-Bold", size: 14)
    static let nameCellLabel = UIFont(name: "Roboto-Regular", size: 12)
}

extension UIColor {
    static let title = white
    static let versus = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    static let league = white
    static let backgroundCell = UIColor(red: 0.153, green: 0.149, blue: 0.227, alpha: 1.0)
    static let divisorView = white.withAlphaComponent(0.2)
    static let backgroundViewColor = UIColor(named: "Background")
    static let backgroundCellRed = UIColor(red: 1.0, green: 0.0, blue: 0.15, alpha: 1.0)
    static let backgroundCellGray = UIColor(red: 0.318, green: 0.314, blue: 0.38, alpha: 1.0)
}
