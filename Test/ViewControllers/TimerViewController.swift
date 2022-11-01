//
//  TimerViewController.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import UIKit

final class TimerViewController: UIViewController, Storyboardable {
  @IBOutlet private weak var timerLabel: UILabel!
  @IBOutlet private weak var progressView: UIProgressView!
  @IBOutlet private weak var continueButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction private func continueTapped(_ sender: UIButton) {
    
  }
}
