//
//  GlobaiNewsApiManagerSpy.swift
//  NewsAppTests
//
//  Created by Nikil Salian on 31/03/22.
//

@testable import NewsApp
import Foundation


final class GlobaiNewsApiManagerSpy: GlobalNewsApiManagerProtocol {

  private var topNewsResponseModel: NewsResponseModel?
  private var popularNewsResponseModel: NewsResponseModel?
  private var error: HandleError?

  func getTopNews(countryCode: String?, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    if let errorUnwrapped = error {
      completion(Result.failure(errorUnwrapped))
    } else {
      guard let modelUnwraped = topNewsResponseModel else {
        completion(Result.failure(.invalidData))
        return
      }
      completion(Result.success(modelUnwraped))
    }
  }

  func getPopularNews(query: String?, from: String?, pageSize: Int, page: Int, completion: @escaping (Result<NewsResponseModel, HandleError>) -> Void) {
    if let errorUnwrapped = error {
      completion(Result.failure(errorUnwrapped))
    } else {
      guard let modelUnwraped = popularNewsResponseModel else {
        completion(Result.failure(.invalidData))
        return
      }
      completion(Result.success(modelUnwraped))
    }
  }

  func addTopNewsResponseStub(dataModel: NewsResponseModel?, error: HandleError?) {
    topNewsResponseModel = dataModel
    self.error = error
  }

  func addPopularNewsResponseStub(dataModel: NewsResponseModel?, error: HandleError?) {
    popularNewsResponseModel = dataModel
    self.error = error
  }
}
