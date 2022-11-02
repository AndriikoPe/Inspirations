//
//  StartCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

final class StartCoordinator: BaseCoordinator {
  let router: Routing
  
  init(router: Routing) {
    self.router = router
  }
  
  override func start() {
    let startVC = StartViewController.instantiate()
    startVC.coordinator = self
    router.setViewControllers([startVC], isAnimated: true)
  }
  
  func gotoInspiration() {
    let inspirationCoordinator = InspirationCoordinator(router: router)
    children.append(inspirationCoordinator)
    inspirationCoordinator.start()
  }
}
