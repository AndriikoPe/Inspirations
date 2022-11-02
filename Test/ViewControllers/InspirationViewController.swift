//
//  InspirationViewController.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class InspirationViewController: UIViewController, Storyboardable {
  var viewModel: InspirationViewModel!
  private let bag = DisposeBag()
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var pageCotrol: UIPageControl!
  @IBOutlet private weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    setupCollectionView()
  }
  
  private func bindViewModel() {
    bindCollectionView()
    bindPageControl()
    bindButton()
  }
  
  private func setupCollectionView() {
    collectionView.rx
      .setDelegate(self)
      .disposed(by: bag)
  }
  
  private func bindPageControl() {
    viewModel
      .selectedIndex
      .asDriver(onErrorJustReturn: .zero)
      .drive(pageCotrol.rx.currentPage)
      .disposed(by: bag)
  }
  
  private func bindCollectionView() {
    viewModel.inspirations.bind(
      to: collectionView.rx.items
    ) { tableView, index, inspiration in
      let indexPath = IndexPath(item: index, section: 0)
      let cell = tableView.dequeueReusableCell(
        withReuseIdentifier: InspirationCollectionViewCell.id,
        for: indexPath
      ) as! InspirationCollectionViewCell
      cell.configure(with: inspiration)
      
      return cell
    }.disposed(by: bag)
    
    collectionView.rx
      .didEndDisplayingCell
      .subscribe { [weak self] _ in
        guard let self else { return }
        self.viewModel.didEndScrolling(
          with: self.collectionView
            .indexPathsForVisibleItems.map { $0.item }
          )
      }
      .disposed(by: bag)
    
    viewModel
      .selectedIndex
      .skip(1)
      .subscribe { [collectionView] index in
        collectionView?.scrollToItem(
          at: IndexPath(item: index, section: 0),
          at: .centeredHorizontally,
          animated: true
        )
      }
      .disposed(by: bag)
  }
  
  private func bindButton() {
    viewModel
      .isLastPage
      .subscribe { [nextButton] isLast in
        nextButton?.setTitle(isLast ? "Continue" : "Next", for: .normal)
      }
      .disposed(by: bag)
    
    viewModel
      .showAlert
      .subscribe(onNext: showAlert)
      .disposed(by: bag)
  }
  
  private func showAlert() {
    let alert = UIAlertController(
      title: viewModel.alertTitle,
      message: viewModel.alertBody,
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(okAction)
    present(alert, animated: true)
  }
  
  @IBAction private func nextTapped(_ sender: Any) {
    viewModel.nextTapped()
  }
}

extension InspirationViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize { collectionView.frame.size }
}
