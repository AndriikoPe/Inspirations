//
//  StartCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

final class StartCoordinator: Coordinator {
  let navigationController: UINavigationController
  private(set) var children: [Coordinator] = []
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let startVC = StartViewController.instantiate()
    startVC.coordinator = self
    navigationController.setViewControllers([startVC], animated: true)
  }
  
  func gotoInspiration() {
    let inspirationCoordinator = InspirationCoordinator(
      navigationController: navigationController
    )
    children.append(inspirationCoordinator)
    inspirationCoordinator.start()
  }
}
