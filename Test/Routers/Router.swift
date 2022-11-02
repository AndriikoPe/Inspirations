//
//  Router.swift
//  Test
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit

final class Router: NSObject {
  let navigationController: UINavigationController
  private var closures = [String: () -> ()]()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    super.init()
    navigationController.delegate = self
  }
}

extension Router: Routing {
  func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack closure: (() -> ())?) {
    guard let viewController = drawable.viewController
    else { return }
    closures[viewController.description] = closure
    navigationController.pushViewController(viewController, animated: isAnimated)
  }
  
  func pop(_ isAnimated: Bool) {
    navigationController.popViewController(animated: isAnimated)
  }
  
  func setViewControllers(_ drawables: [Drawable], isAnimated: Bool) {
    navigationController.setViewControllers(drawables.compactMap { $0.viewController }, animated: true)
  }
  
  func executeClosure(_ viewController: UIViewController) {
    closures.removeValue(forKey: viewController.description)?()
  }
  
  func present(_ drawable: Drawable, isAnimated: Bool, onDismiss closure: (() -> ())?) {
    guard let viewController = drawable.viewController else { return }
    closures[viewController.description] = closure
    navigationController.present(viewController, animated: isAnimated)
    viewController.presentationController?.delegate = self
  }
}

extension Router: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard let previousController = navigationController
      .transitionCoordinator?.viewController(forKey: .from),
          !navigationController.viewControllers.contains(previousController)
    else { return }
    executeClosure(previousController)
  }
}

extension Router: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    executeClosure(presentationController.presentedViewController)
  }
}
