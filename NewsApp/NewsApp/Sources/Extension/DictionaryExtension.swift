//
//  DictionaryExtension.swift
//  NewsApp
//
//  Created by Nikil Salian on 31/03/22.
//

import Foundation

extension Dictionary {
  
  var queryItem: [URLQueryItem]? {
    var output: [URLQueryItem] = []
    for (key, value) in self {
      output.append(URLQueryItem(name: "\(key)", value: "\(value)"))
    }
    return output
  }
}
