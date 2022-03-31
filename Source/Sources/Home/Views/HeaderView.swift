//
//  HeaderView.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation
import UIKit

final class HeaderView: UIView {
  @IBOutlet private weak var titleLabel: UILabel!

  static func loadNib() -> HeaderView {
    guard let view =  Bundle.main.loadNibNamed(self.name(), owner: nil, options: nil)?.first as? HeaderView else {
      return HeaderView()
    }
    return view
  }

  func configure(title: String?) {
    self.titleLabel.text = title
  }
}
