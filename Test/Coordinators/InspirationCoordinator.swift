//
//  InspirationCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

final class InspirationCoordinator: Coordinator {
  private(set) var children: [Coordinator] = []
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let inspirationVC = InspirationViewController.instantiate()
    inspirationVC.coordinator = self
    inspirationVC.viewModel = InspirationViewModel()
    navigationController.setViewControllers([inspirationVC], animated: true)
  }
}
