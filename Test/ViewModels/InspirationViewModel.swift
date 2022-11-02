//
//  InspirationViewModel.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class InspirationViewModel {
  weak var coordinator: InspirationCoordinator?
  let selectedIndex = BehaviorSubject(value: 0)
  let isLastPage = BehaviorSubject(value: false)
  
  private(set) lazy var inspirations = Observable.of(hardcodedInspirations)
  
  private let bag = DisposeBag()
  private let coreDataManager = CoreDataManager.shared
  private let hardcodedInspirations = [
    Inspiration(
      imageName: "boostProductivity",
      title: "Boost Productivity",
      description: "Take your productivity to the next level"
    ),
    Inspiration(
      imageName: "workSeemlessly",
      title: "Work Seamlessly",
      description: "Get your work done seamlessly without interruption"
    ),
    Inspiration(
      imageName: "achieveGoals",
      title: "Achieve Your Goals",
      description: "Boosted productivity will help you achieve the desired goals"
    )
  ]
  
  init() {
//    Uncomment to print how many times each screen has been shown.
//    let seen = coreDataManager.fetchSeen()
//    seen.forEach {
//      print("Seen \($0.inspirationTitle ?? "something") \($0.timesShown) times")
//    }
    selectedIndex
      .distinctUntilChanged()
      .subscribe { [unowned self] in
        coreDataManager.incrementSeen(
          for: hardcodedInspirations[$0].title
        )
      }.disposed(by: bag)
  }
  
  func nextTapped() {
    let nextIndex = 1 + ((try? selectedIndex.value()) ?? .zero)
    if (try? isLastPage.value()) == true {
      coordinator?.gotoTimer()
    } else if hardcodedInspirations.indices.contains(nextIndex) {
      selectedIndex.onNext(nextIndex)
    }
    updateIsLastPage(nextIndex)
  }
  
  func didEndScrolling(with visibleIndices: [Int]) {
    guard visibleIndices.count == 1, let next = visibleIndices.first
    else { return }
    selectedIndex.onNext(next)
    updateIsLastPage(next)
  }
  
  private func updateIsLastPage(_ index: Int) {
    // Scrolling back won't chage back to 'Next'.
    if isLast(index: index) { isLastPage.onNext(true) }
  }
  
  private func isLast(index: Int) -> Bool {
    index == hardcodedInspirations.endIndex - 1
  }
}
