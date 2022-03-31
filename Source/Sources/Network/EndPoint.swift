//
//  EndPoint.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation

protocol EndPoint {
  var path: String { get }
  var params: Data? { get }
  var method: Method { get }
  var queryDictionary: [String: Any]? { get }
  var host: String { get }
  var requestHeader: [String: String]? { get }
}

enum Method: String {
  case get = "GET"
}

extension EndPoint {
  
  var headers: [String: String] {
    var headersList = [String: String]()
    if requestHeader?.isEmpty == false {
      for (key, val) in requestHeader! {
        headersList[key] = val
      }
    }
    return headersList
  }

  var dataParms: Data? {
    return params
  }

  var urlComponents: URLComponents {
    var component = URLComponents()
    component.scheme = "https"
    component.host = host
    component.path = path
    component.queryItems = queryDictionary?.queryItem
    return component
  }

  var request: URLRequest? {
    guard let url = urlComponents.url else {
      return nil
    }
    var requestURL = URLRequest(url: url)
    requestURL.httpMethod = method.rawValue
    requestURL.httpBody = dataParms
    requestURL.allHTTPHeaderFields = headers
    requestURL.httpShouldHandleCookies = true
    return requestURL
  }
}
