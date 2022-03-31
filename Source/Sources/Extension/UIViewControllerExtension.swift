//
//  UIViewControllerExtension.swift
//  NewsApp
//
//  Created by Nikil Salian on 31/03/22.
//

import UIKit

private var activityIndicator: UIActivityIndicatorView?

extension UIViewController {
  
  func showSpinner(with color: UIColor = .white) {
    activityIndicator?.frame = self.view.frame
    if #available(iOS 13.0, *) {
      if #available(tvOS 13.0, *) {
        activityIndicator = UIActivityIndicatorView(style: .large)
      } else {
        activityIndicator = UIActivityIndicatorView(style: .white)
      }
    } else {
      activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    }
    if let activityIndicator = activityIndicator {
      activityIndicator.color = color
      let frameSizeCenter = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y: UIScreen.main.bounds.size.height * 0.5)
      activityIndicator.center = frameSizeCenter
      activityIndicator.startAnimating()
      self.view.addSubview(activityIndicator)
      self.view.bringSubviewToFront(activityIndicator)
    }
  }
  
  func removeSpinner() {
    DispatchQueue.main.async {
      if let activityIndicator = activityIndicator {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
      }
    }
  }
}
