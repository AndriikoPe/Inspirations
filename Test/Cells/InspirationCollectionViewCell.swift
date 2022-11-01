//
//  InspirationCollectionViewCell.swift
//  Test
//
//  Created by Пермяков Андрей on 30.10.2022.
//

import UIKit

final class InspirationCollectionViewCell: UICollectionViewCell {
  static var id: String { String(describing: self) }
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  
  func configure(with inspiration: Inspiration) {
    imageView.image = UIImage(named: inspiration.imageName)
    titleLabel.text = inspiration.title
    descriptionLabel.text = inspiration.description
  }
}
