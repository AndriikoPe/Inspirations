//
//  TimerCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import UIKit

final class TimerCoordinator: Coordinator {
  private(set) var children: [Coordinator] = []
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let timerVC = TimerViewController.instantiate()
    
  }
}
