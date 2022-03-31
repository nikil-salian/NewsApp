//
//  StringExtension.swift
//  NewsApp
//
//  Created by Nikil Salian on 31/03/22.
//

extension String {
  
  /// This method returns Class name as String
  ///
  /// - Parameter objectClass: AnyClass
  /// - Returns: String
  static func getStringOfClass(objectClass: AnyClass) -> String {
    let className = String(describing: objectClass.self)
    return className
  }
}
