//
//  Coordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 29.10.2022.
//

import UIKit

protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
  
  func start()
}

extension Coordinator {
  func remove(coordinator: Coordinator) {
    children = children.filter { $0 !== coordinator }
  }
}
