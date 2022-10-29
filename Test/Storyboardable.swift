//
//  Storyboardable.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

protocol Storyboardable {
  static func instantiate() -> Self
}

extension Storyboardable where Self: UIViewController {
  static func instantiate() -> Self {
    UIStoryboard(name: "Main", bundle: .main).instantiateViewController(
      withIdentifier: String(describing: Self.self)
    ) as! Self
  }
}
