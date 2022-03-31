//
//  GlobalNewsApiManager.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

protocol GlobalNewsApiManagerProtocol {
  func getTopNews(countryCode: String?, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void)
  func getPopularNews(query: String?, from: String?, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void)
}

final class GlobalNewsApiManager: GlobalNewsApiManagerProtocol {

  private let network: NetworkManager

  init(network: NetworkManager = NetworkManager.shared) {
    self.network = network
  }

  func getTopNews(countryCode: String?, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    let host = NetworkHostConstant.host
    let path = NewsApiPathComponet.topNews.basePath
    var queryParameters: [String: Any] = [:]
    queryParameters[APIConstant.country] = countryCode
    queryParameters[APIConstant.apiKey] = APIConstant.apiKeyValue
    queryParameters[APIConstant.pageSize] =  1
    queryParameters[APIConstant.page] =  1
    let config = ConfigureRequest(path: path, params: nil, method: .get, queryDictionary: queryParameters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }

  func getPopularNews(query: String?, from: String?, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    let host = NetworkHostConstant.host
    let path = NewsApiPathComponet.popularNews.basePath
    var queryParameters: [String: Any] = [:]
    queryParameters[APIConstant.query] = query
    queryParameters[APIConstant.from] = from
    queryParameters[APIConstant.sortBy] = APIConstant.popularity
    queryParameters[APIConstant.apiKey] = APIConstant.apiKeyValue
    queryParameters[APIConstant.pageSize] =  pageSize
    queryParameters[APIConstant.page] =  page
    let config = ConfigureRequest(path: path, params: nil, method: .get, queryDictionary: queryParameters, host: host, requestHeader: nil)
    network.request(with: config.request, completion: completion)
  }
}
