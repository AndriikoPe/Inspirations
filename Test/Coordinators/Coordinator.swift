//
//  Coordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 29.10.2022.
//

import UIKit

protocol Coordinator {
  var children: [Coordinator] { get }
  var navigationController: UINavigationController { get }
  
  func start()
}
