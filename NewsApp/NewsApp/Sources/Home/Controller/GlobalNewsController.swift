//
//  GlobalNewsController.swift
//  NewsApp
//
//  Created by Nikil Salian on 29/03/22.
//

import Foundation
import UIKit

final class GlobalNewsController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  let viewModel = GlobalNewsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupTableView()
    setupViewModel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigation()
  }
}

private extension GlobalNewsController {

  func setupNavigation() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  func setupViewModel() {
    showSpinner(with: .lightGray)
    viewModel.reloadData = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
        self?.removeSpinner()
      }
    }
    
    viewModel.didReceiveServiceError = { [weak self] error in
      self?.removeSpinner()
      DispatchQueue.main.async {
        self?.showAlert(title: error.localizedDescription, message: ErrorConstant.somethingWentWrong)
      }
    }
    viewModel.fetchTopNews()
  }
  
  func setupTableView() {
    tableView.registerCellTypes([TopNewsTableViewCell.self])
    tableView.registerCellTypes([PopularNewsTableViewCell.self])
    tableView.delegate = self
    tableView.dataSource = self
  }
}

// MARK: UITableViewDataSource
extension GlobalNewsController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let section = viewModel.layouts?[section] else {
      return 0
    }
    
    switch section {
    case .topNews(_, _):
      return 1
    case .popularNews(_, let items):
      return items.count
    }
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.layouts?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = viewModel.layouts?[indexPath.section] else {
      return UITableViewCell()
    }
    switch section {
    case .topNews(_, let item):
      let cell = tableView.dequeueReusableCell(TopNewsTableViewCell.self, indexPath: indexPath)
      cell.configure(item: item)
      return cell
    case .popularNews(_, let items):
      let cell = tableView.dequeueReusableCell(PopularNewsTableViewCell.self, indexPath: indexPath)
      if let item = items[safe: indexPath.row] {
        cell.configure(item: item)
      }
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let section = viewModel.layouts?[indexPath.section] else {
      return
    }
    switch section {
    case .popularNews(_, let items):
      if indexPath.row + 1 == items.count {
        viewModel.loadMorePopularNews()
      }
    default:
      break
    }
  }
}

// MARK: UITableViewDelegate
extension GlobalNewsController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let section = viewModel.layouts?[indexPath.section] else {
      return  0
    }
    switch section {
    case .topNews(_, _):
      return UITableView.automaticDimension
    case .popularNews(_, _):
      return Utility.isiPad() ? 160.0: 140.0
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let section = viewModel.layouts?[section] else {
      return  nil
    }
    
    let view = HeaderView.loadNib()
    switch section {
    case .topNews(let title, _):
      view.configure(title: title)
    case .popularNews(let title, _):
      view.configure(title: title)
    }
    return view
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let section = viewModel.layouts?[section] else {
      return  nil
    }
    
    switch section {
    case .topNews(_, _):
      let view = UIView()
      view.backgroundColor = .clear
      return view
    case .popularNews(_, _):
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50.0
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 45.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let layout = viewModel.layouts?[indexPath.section] else {
      return
    }
    let article: ArticleDisplayble?
    switch layout {
    case .topNews(_, let item):
      article = item
    case .popularNews(_, let items):
      if let item = items[safe: indexPath.row] {
        article = item
      } else {
        article = nil
      }
    }
    
    let newsArticleDetailViewController = NewsArticleDetailViewController.instance
    newsArticleDetailViewController.urlString = article?.articleUrl
    newsArticleDetailViewController.articleTitle = article?.articleAuthor
    self.navigationController?.pushViewController(newsArticleDetailViewController, animated: true)
  }
}

private extension GlobalNewsController {
  
  func showAlert(title: String?, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: AlertConstant.ok, style: UIAlertAction.Style.default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
