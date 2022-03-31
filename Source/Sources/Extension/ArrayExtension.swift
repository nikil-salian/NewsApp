//
//  ArrayExtension.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

extension Array {
  /// Returns an element by the given index or `nil`.
  subscript(safe index: Int) -> Element? {
    guard index >= 0, index < endIndex else { return nil }
    return self[index]
  }
}

