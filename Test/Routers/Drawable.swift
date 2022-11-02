//
//  Drawable.swift
//  Test
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import UIKit

protocol Drawable {
  var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
  var viewController: UIViewController? { self }
}
