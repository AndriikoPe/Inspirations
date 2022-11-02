//
//  TimverViewModel.swift
//  Test
//
//  Created by Пермяков Андрей on 02.11.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class TimerViewModel {
  weak var coordinator: TimerCoordinator?
  
  let timer: Observable<Int>
  private let totalMilliseconds: Float = 60 * 1000.0
  
  private let formatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    return formatter
  }()
  
  init() {
    timer = Observable<Int>.timer(
      .seconds(0),
      period: .milliseconds(1),
      scheduler: MainScheduler.instance
    )
      .take(Int(totalMilliseconds) + 1)
  }
  
  func millisecondsToTime(_ seconds: Int) -> String {
    formatter.string(from: TimeInterval(seconds / 1000)) ?? ""
  }
  
  func progress(from milliseconds: Int) -> Float {
    Float(milliseconds) / (totalMilliseconds)
  }
  
  func continueTapped() {
    coordinator?.dismiss()
  }
}
