//
//  TopNewsTableViewCell.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import UIKit

final class TopNewsTableViewCell: UITableViewCell {

  @IBOutlet private weak var thumbnailImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descLabel: UILabel!
  @IBOutlet private weak var authorButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  func configure(item: ArticleDisplayble) {
    thumbnailImageView.loadRemoteImageFrom(urlString: item.imageUrl)
    titleLabel.text = item.articleTitle
    descLabel.text = item.articleDesc
    authorButton.setTitle(item.articleSource, for: .normal)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    authorButton.layer.cornerRadius = 13
    authorButton.clipsToBounds = true
  }
}
