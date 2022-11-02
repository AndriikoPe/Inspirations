//
//  TimerCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import UIKit

final class TimerCoordinator: BaseCoordinator {
  let router: Routing
  
  private weak var timerVC: TimerViewController?
  
  init(router: Routing) {
    self.router = router
  }
  
  override func start() {
    let timerVC = TimerViewController.instantiate()
    self.timerVC = timerVC
    let viewModel = TimerViewModel()
    viewModel.coordinator = self
    timerVC.viewModel = viewModel
    timerVC.modalPresentationStyle = .overFullScreen
    timerVC.modalTransitionStyle = .crossDissolve
    router.present(timerVC, isAnimated: true, onDismiss: isCompleted) 
    Defaults.timerShown = true
  }
  
  func dismiss() {
    timerVC?.dismiss(animated: true)
  }
}
