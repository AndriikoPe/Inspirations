//
//  InspirationCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

final class InspirationCoordinator: BaseCoordinator {
  let router: Routing
  
  init(router: Routing) {
    self.router = router
  }
  
  override func start() {
    let inspirationVC = InspirationViewController.instantiate()
    
    let viewModel = InspirationViewModel()
    viewModel.coordinator = self
    inspirationVC.viewModel = viewModel
    router.setViewControllers([inspirationVC], isAnimated: true)
  }
  
  func gotoTimer() {
    let timerCoordinator = TimerCoordinator(router: router)
    children.append(timerCoordinator)
    timerCoordinator.isCompleted = { [weak self, weak timerCoordinator] in
      guard let coordinator = timerCoordinator else { return }
      self?.remove(coordinator: coordinator)
    }
    timerCoordinator.start()
  }
}
