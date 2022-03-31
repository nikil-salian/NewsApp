//
//  Result.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation

enum Result<T, E> where E: Error {
  case success(T)
  case failure(E)
}

enum HandleError: Error {
  case invalidRequest
  case resourceTimedOut
  case responseUnsuccessful
  case jsonConversionFailure
  case invalidData


  var localizedDescription: String {
    switch self {
    case .invalidRequest:
      return "Invalid Request"
    case .resourceTimedOut:
      return "Resource timed out"
    case .responseUnsuccessful:
      return "Response Unsuccessful";
    case .jsonConversionFailure:
      return "JSON Conversion Failure"
    case .invalidData:
      return "Invalid Data"
    }
  }
}


