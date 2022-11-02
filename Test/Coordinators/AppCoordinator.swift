//
//  AppCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 29.10.2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
  let window: UIWindow
  let router: Routing
  private let navigationController = UINavigationController()
  
  init(window: UIWindow) {
    self.window = window
    self.router = Router(navigationController: navigationController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  override func start() {
    let startCoordinator = StartCoordinator(router: router)
    children.append(startCoordinator)
    startCoordinator.start()
  }
}
