//
//  BaseCoordinator.swift
//  Test
//
//  Created by Пермяков Андрей on 03.11.2022.
//

import Foundation

class BaseCoordinator: Coordinator {  
  var children: [Coordinator] = []
  var isCompleted: (() -> ())?
  
  func start() {}
}
