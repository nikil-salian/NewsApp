//
//  ConfigureRequest.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation

struct ConfigureRequest: EndPoint {
  var path: String
  var params: Data?
  var method: Method
  var queryDictionary: [String: Any]?
  var host: String
  var requestHeader: [String: String]?
}


