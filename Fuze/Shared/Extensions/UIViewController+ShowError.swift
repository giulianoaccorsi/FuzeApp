//
//  UIViewController+ShowError.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import UIKit

extension UIViewController {
    func showError(errorMessage: String) {
        let alertController = UIAlertController(title: "Error :(", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}
