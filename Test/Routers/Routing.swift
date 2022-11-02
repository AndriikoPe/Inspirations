//
//  RouterProtocol.swift
//  Test
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit

protocol Routing {
  func push(_ drawable: Drawable, isAnimated: Bool, onNavigationBack: (() -> ())?)
  func pop(_ isAnimated: Bool)
  func setViewControllers(_ drawables: [Drawable], isAnimated: Bool)
  func present(_ drawable: Drawable, isAnimated: Bool, onDismiss: (() -> ())?)
}
