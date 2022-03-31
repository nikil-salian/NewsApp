//
//  UITableViewExtension.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import UIKit

extension UITableView {
  
  func registerCellTypes(_ cells: [UITableViewCell.Type]) {
    cells.forEach { registerCell($0) }
  }
  
  func registerCell<T: UITableViewCell>(_ cellName: T.Type) {
    self.register(UINib(nibName: cellName.name(), bundle: nil), forCellReuseIdentifier: cellName.name())
  }
  
  func dequeueCell<T: UITableViewCell>(_ cellName: T.Type, at indexPath: IndexPath) -> T? {
    guard let cell = self.dequeueReusableCell(withIdentifier: cellName.name(), for: indexPath) as? T else {
      return nil
    }
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: T.name(), for: indexPath) as! T
  }
}
