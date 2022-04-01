//
//  GlobalNewsViewModel.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation

// MARK: GlobalNewsViewModelInputs
protocol GlobalNewsViewModelInputs {
  func fetchTopNews()
  func loadMorePopularNews()
  
  var layouts: [GlobalNewsLayout]? { get }
}

// MARK: GlobalNewsViewModelOutputs
protocol GlobalNewsViewModelOutputs {
  var didReceiveServiceError: ((HandleError) -> Void) { get set }
  var reloadData: (() -> Void) { get set }
}


// MARK: GlobalNewsLayout
enum GlobalNewsLayout {
  case topNews(title: String, item: ArticleDisplayble)
  case popularNews(title: String, items: [ArticleDisplayble])
}


// MARK: GlobalNewsViewModelInputs, GlobalNewsViewModelOutputs
final class GlobalNewsViewModel: GlobalNewsViewModelInputs, GlobalNewsViewModelOutputs {
  
  private let serivce: GlobalNewsApiManagerProtocol
  private var availableLayouts: [GlobalNewsLayout]?
  private var totalResults = 0
  private let numberOfItemsPerPage = 10
  private var currentPage = 1
  private var isLoadMoreInProgress = false
  
  var layouts: [GlobalNewsLayout]? { return availableLayouts}
  
  // MARK: Initiliation
  init(serivce: GlobalNewsApiManagerProtocol = GlobalNewsApiManager()) {
    self.serivce = serivce
  }
  
  func fetchTopNews() {
    // As of now we are passing the coun try code as india
    serivce.getTopNews(countryCode: "in") { [weak self] result in
      switch result {
      case .success(let model):
        self?.groupTopNewsLayouts(response: model)
      case .failure(let error):
        self?.didReceiveServiceError(error)
      }
      self?.fetchPopularNews()
    }
  }
  
  var didReceiveServiceError: ((HandleError) -> Void) = { _ in }
  var reloadData: (() -> Void) = { }
  
  
  func groupTopNewsLayouts(response: NewsResponseModel) {
    availableLayouts = [GlobalNewsLayout]()
    if let article = response.articles?.first {
      availableLayouts?.append(.topNews(title: AppConstnat.topNews, item: article))
    }
    reloadData()
  }
  
  func fetchPopularNews(isPaginated: Bool = false) {
    // Create Date
    let date = Date()
    
    // Create Date Formatter
    let dateFormatter = DateFormatter()
    
    // Set Date Format
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // Convert Date to String
    let convertedDateString = dateFormatter.string(from: date)
    
    // fetching the popular news based on the keyword apple
    serivce.getPopularNews(query: "apple", from: convertedDateString, pageSize: numberOfItemsPerPage, page: currentPage) { [weak self] result in
      switch result {
      case .success(let response):
        self?.groupPopularNewsLayouts(response: response, isPaginated: isPaginated)
      case .failure(let error):
        self?.isLoadMoreInProgress = false
        self?.didReceiveServiceError(error)
      }
    }
  }
  
  func groupPopularNewsLayouts(response: NewsResponseModel, isPaginated: Bool = false) {
    totalResults = response.totalResults ?? 0
    if availableLayouts == nil {
      availableLayouts = [GlobalNewsLayout]()
    }
    if let articles = response.articles {
      if isPaginated {
        updateAvailablePopularNewsLayouts(articles: articles)
      } else {
        availableLayouts?.append(.popularNews(title: AppConstnat.popularNews, items: articles))
      }
    }
    reloadData()
  }
  
  func loadMorePopularNews() {
    currentPage += 1

    // Note: 100 is maximum articles which we can fetch from the api.
    guard !isLoadMoreInProgress,
          let layout = availableLayouts?.last,
          case .popularNews(_ , let items) = layout,
          items.count < min(totalResults, 100) else {
            return
          }
    isLoadMoreInProgress = true
    fetchPopularNews(isPaginated: true)
  }
  
  func updateAvailablePopularNewsLayouts(articles: [Article]) {
    if let layout = availableLayouts?.last {
      if case .popularNews(_ , var items) = layout {
        items.append(contentsOf: articles)
        availableLayouts?.removeLast()
        availableLayouts?.append(.popularNews(title: AppConstnat.popularNews, items: items))
      }
    }
    isLoadMoreInProgress = false
  }
}
