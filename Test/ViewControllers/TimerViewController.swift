//
//  TimerViewController.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import UIKit
import RxSwift

final class TimerViewController: UIViewController, Storyboardable {
  @IBOutlet private weak var timerLabel: UILabel!
  @IBOutlet private weak var progressView: UIProgressView!
  @IBOutlet private weak var continueButton: UIButton!
  private let progressViewDesiredHeight = 8.0
  private let bag = DisposeBag()
  
  var viewModel: TimerViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupProgressView()
    bindViewModel()
  }
  
  private func setupProgressView() {
    progressView.transform = CGAffineTransform(
      scaleX: 1.0,
      y: progressViewDesiredHeight / progressView.frame.height
    )
  }
  
  private func bindViewModel() {
    viewModel.timer
      .subscribe(onNext: { [weak self] seconds in
        guard let self else { return }
        self.progressView.setProgress(
          self.viewModel.progress(from: seconds),
          animated: true
        )
        self.timerLabel.text = self.viewModel.millisecondsToTime(seconds)
      }, onCompleted: { [continueButton] in
        continueButton?.isEnabled = true
        continueButton?.backgroundColor = .contentAccent
      })
      .disposed(by: bag)
  }
  
  @IBAction private func continueTapped(_ sender: UIButton) {
    viewModel.continueTapped()
  }
}
