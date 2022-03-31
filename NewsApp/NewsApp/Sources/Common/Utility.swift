//
//  Utility.swift
//  NewsApp
//
//  Created by Nikil Salian on 31/03/22.
//

import UIKit

final class Utility {
  static func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
}
