//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation

class NetworkManager: NSObject {
  static let shared = NetworkManager()
  private var session: URLSession!

  private override init() {
    super.init()
    session = URLSession(configuration: defaultConfiguration)
  }

  fileprivate var defaultConfiguration: URLSessionConfiguration! {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 120
    config.timeoutIntervalForResource = 60
    config.waitsForConnectivity = true
    return config
  }

  func request<T: Decodable> (with requests: URLRequest?,
                              completion: @escaping (Result<T, HandleError>) -> Void) {
    guard let request = requests else {
      completion(Result.failure(.invalidRequest))
      return
    }
    debugPrint("request: \(request)")
    let task = session?.dataTask(with: request) { data, response, error in
      if let err = error {
        if err._domain == NSURLErrorDomain && err._code == NSURLErrorTimedOut {
          completion(Result.failure(.resourceTimedOut))
        } else {
          completion(Result.failure(.responseUnsuccessful))
        }
        return
      }

      if let data = data {
        do {
          let genericModel = try JSONDecoder().decode(T.self, from: data)
          completion(Result.success(genericModel))
        } catch {
          completion(Result.failure(.jsonConversionFailure))
        }
      } else {
        completion(Result.failure(.invalidData))
        return
      }
    }
    task?.resume()
  }
}
