//
//  AppCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 29.10.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
  let window: UIWindow
  let navigationController: UINavigationController
  private(set) var children: [Coordinator] = []
  
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func start() {
    let startCoordinator = StartCoordinator(
      navigationController: navigationController
    )
    children.append(startCoordinator)
    startCoordinator.start()
  }
}
