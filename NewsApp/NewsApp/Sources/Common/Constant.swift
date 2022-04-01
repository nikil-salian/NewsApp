//
//  Constant.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

enum APIConstant {
  static let apiKeyValue = "6849398cf0e74e2db2b630a22b6b20e3"
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

enum NewsAPIComponet {
  case topNews(countryCode: String, pageSize: Int, page: Int)
  case popularNews(query: String?, from: String?, sortBy: String?, pageSize: Int, page: Int)

  var basePath: String {
    return "/v2/\(path)"
  }

  var path: String {
    switch self {
    case .topNews(_, _, _):
      return "top-headlines"
    case .popularNews(_, _, _, _, _):
      return "everything"
    }
  }

  var queryParmeters: [String: Any] {
    switch self {
    case let .topNews(countryCode, pageSize, page):
      var queryParams = defaultParmeters(pageSize: pageSize, page: page)
      queryParams[APIConstant.country] = countryCode
      return queryParams
    case let .popularNews(query, from, sortBy, pageSize, page):
      var queryParams = defaultParmeters(pageSize: pageSize, page: page)
      queryParams[APIConstant.query] = query
      queryParams[APIConstant.from] = from
      queryParams[APIConstant.sortBy] = sortBy
      return queryParams

    }
  }

  func defaultParmeters(pageSize: Int, page: Int) -> [String: Any] {
    var queryParameters = [String: Any]()
    queryParameters[APIConstant.apiKey] = APIConstant.apiKeyValue
    queryParameters[APIConstant.pageSize] = pageSize
    queryParameters[APIConstant.page] = page
    return queryParameters
  }
}

enum ErrorConstant {
  static let somethingWentWrong = "Something went wrong"
}

enum AlertConstant {
  static let ok = "OK"
}

enum AppConstnat {
  static let topNews = "Top News"
  static let popularNews = "Popular News"
}




