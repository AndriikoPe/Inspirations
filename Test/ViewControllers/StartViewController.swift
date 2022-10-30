//
//  ViewController.swift
//  Test
//
//  Created by Пермяков Андрей on 28.10.2022.
//

import UIKit

final class StartViewController: UIViewController, Storyboardable {
  weak var coordinator: StartCoordinator?
  
  @IBAction private func startTapped(_ sender: Any) {
    coordinator?.gotoInspiration()
  }
}

