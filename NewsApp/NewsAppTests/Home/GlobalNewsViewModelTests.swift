//
//  GlobalNewsViewModelTests.swift
//  NewsAppTests
//
//  Created by Nikil Salian on 31/03/22.
//

import XCTest
@testable import NewsApp

let topNewsStubJson = "top-news-test"
let popularNewsStunJson = "popular-news-test"

class GlobalNewsViewModelTests: XCTestCase {

  var viewModel: GlobalNewsViewModel?

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    let topNewsModel: NewsResponseModel! = testItem(for: topNewsStubJson)
    let spy = GlobaiNewsApiManagerSpy()
    spy.addTopNewsResponseStub(dataModel: topNewsModel, error: nil)

    let popularNewsModel: NewsResponseModel! = testItem(for: popularNewsStunJson)
    spy.addPopularNewsResponseStub(dataModel: popularNewsModel, error: nil)
    viewModel = GlobalNewsViewModel(serivce: spy)
    setupViewModel()
  }

  func setupViewModel() {
    viewModel?.reloadData = { [weak self] in
      XCTAssertTrue(!(self?.viewModel?.layouts?.isEmpty ?? false), "Layouts are not available to render the page")
    }

    viewModel?.didReceiveServiceError  = { error in
      XCTAssertNotNil(error, "Error should be there")
    }
  }

  func testSucess() {
    viewModel?.fetchTopNews()
    viewModel?.loadMorePopularNews()
  }

  func testFailure() {
    let spy = GlobaiNewsApiManagerSpy()
    spy.addTopNewsResponseStub(dataModel: nil, error: HandleError.invalidData)
    spy.addPopularNewsResponseStub(dataModel: nil, error: HandleError.invalidRequest)
    viewModel = GlobalNewsViewModel(serivce: spy)
    viewModel?.fetchTopNews()
  }
}
