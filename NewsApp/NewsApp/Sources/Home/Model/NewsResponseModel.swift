//
//  NewsResponseModel.swift
//  NewsApp
//
//  Created by Nikil Salian on 30/03/22.
//

import Foundation

// MARK: NewsResponseModel
struct NewsResponseModel: Codable {
  let status: String?
  let totalResults: Int?
  let articles: [Article]?
}

// MARK: Article
class Article: Codable {
  let source: ArticleSource?
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?
}

// MARK: ArticleSource
class ArticleSource: Codable {
  let id: String?
  let name: String?
}

// MARK: ArticleDisplayble
protocol ArticleDisplayble {
  var articleTitle: String? { get }
  var articleDesc: String? { get }
  var imageUrl: String? { get }
  var articleSource: String? { get }
  var articleUrl: String? { get }
  var articleAuthor: String? { get }
}


extension Article: ArticleDisplayble {
  
  var articleTitle: String? {
    return title
  }
  
  var articleDesc: String? {
    return description
  }
  
  var imageUrl: String? {
    return urlToImage
  }
  
  var articleSource: String? {
    return source?.name
  }
  
  var articleUrl: String? {
    return url
  }
  
  var articleAuthor: String? {
    return author
  }
}


