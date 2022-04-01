//
//  GlobalNewsApiManager.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

protocol GlobalNewsApiManagerProtocol {
  func getTopNews(countryCode: String, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void)
  func getPopularNews(query: String, from: String, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void)
}

final class GlobalNewsApiManager: GlobalNewsApiManagerProtocol {

  private let network: NetworkManager

  init(network: NetworkManager = NetworkManager.shared) {
    self.network = network
  }

  func getTopNews(countryCode: String, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    let host = NetworkHostConstant.host
    let path = NewsApiPathComponet.topNews.basePath
    let queryParameters = News.topNews(countryCode: countryCode, pageSize: 1, page: 1).queryParmeters
    let config = ConfigureRequest(path: path, params: nil, method: .get, queryDictionary: queryParameters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }

  func getPopularNews(query: String, from: String, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    let host = NetworkHostConstant.host
    let path = NewsApiPathComponet.popularNews.basePath
    let queryParameters = News.popular(query: query, from: from, sortBy: APIConstant.popularity, pageSize: pageSize, page: page).queryParmeters
    let config = ConfigureRequest(path: path, params: nil, method: .get, queryDictionary: queryParameters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }
}

enum News {
  case topNews(countryCode: String, pageSize: Int, page: Int)
  case popular(query: String?, from: String?, sortBy: String?, pageSize: Int, page: Int)

  var queryParmeters: [String: Any] {
    switch self {
    case let .topNews(countryCode, pageSize, page):
      var queryParams = defaultParmeters(pageSize: pageSize, page: page)
      queryParams[APIConstant.country] = countryCode
      return queryParams
    case let .popular(query, from, sortBy, pageSize, page):
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
