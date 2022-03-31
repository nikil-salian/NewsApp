//
//  PopularNewsTableViewCell.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import UIKit

final class PopularNewsTableViewCell: UITableViewCell {
  @IBOutlet private weak var thumbnailImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  @IBOutlet private weak var authorButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    authorButton.layer.cornerRadius = 10
    authorButton.clipsToBounds = true
  }
  
  func configure(item: ArticleDisplayble) {
    thumbnailImageView.loadRemoteImageFrom(urlString: item.imageUrl)
    titleLabel.text = item.articleTitle
    subtitleLabel.text = item.articleDesc
    authorButton.setTitle(item.articleSource, for: .normal)
  }
}
