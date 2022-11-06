//
//  Coordinator.swift
//  Fuze
//
//  Created by Giuliano Accorsi on 02/11/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
