//
//  Constant.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

enum APIConstant {
  static let apiKeyValue = "6849398cf0e74e2db2b630a22b6b20e3" // "302e7f29375f4f5e85c71a0edcfb1d69" 
  static let country = "country"
  static let apiKey = "apiKey"
  static let pageSize = "pageSize"
  static let page = "page"
  static let query = "q"
  static let from = "from"
  static let sortBy = "sortBy"
  static let popularity = "popularity"
}

enum NetworkHostConstant {
  static let host = "newsapi.org"
}

enum NewsApiPathComponet {
  case topNews
  case popularNews

  var basePath: String {
    return "/v2/\(path)"
  }

  var path: String {
    switch self {
    case .topNews:
      return "top-headlines"
    case .popularNews:
      return "everything"
    }
  }
}

enum ErrorConstant {
  static let somethingWentWrong = "Something went wrong"
}

enum UIAlertConstant {
  static let ok = "OK"
}

enum AppConstnat {
  static let topNews = "Top News"
  static let popularNews = "Popular News"
}




