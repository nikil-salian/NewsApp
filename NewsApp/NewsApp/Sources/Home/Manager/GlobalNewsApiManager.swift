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
    let apiComponent = NewsAPIComponet.topNews(countryCode: countryCode, pageSize: 1, page: 1)
    let config = ConfigureRequest(path: apiComponent.basePath, params: nil, method: .get, queryDictionary: apiComponent.queryParmeters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }

  func getPopularNews(query: String, from: String, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    let host = NetworkHostConstant.host
    let apiComponent = NewsAPIComponet.popularNews(query: query, from: from, sortBy: APIConstant.popularity, pageSize: pageSize, page: page)
    let config = ConfigureRequest(path: apiComponent.basePath, params: nil, method: .get, queryDictionary: apiComponent.queryParmeters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }
}
