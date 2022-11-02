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
  
  let totalTime: Float = 60.0
  let timer: Observable<Int>
  
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
      period: .seconds(1),
      scheduler: MainScheduler.instance
    )
      .take(Int(totalTime) + 1)
  }
  
  func secondsToTime(_ seconds: Int) -> String {
    formatter.string(from: TimeInterval(seconds)) ?? ""
  }
  
  func progress(from seconds: Int) -> Float {
    Float(seconds) / totalTime
  }
}
