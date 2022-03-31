//
//  NewsArticleDetailViewController.swift
//  NewsApp
//
//  Created by Nikil Salian on 31/03/22.
//

import UIKit
import WebKit

class NewsArticleDetailViewController: UIViewController {
  @IBOutlet private weak var webContainerView: UIView!
  @IBOutlet private weak var titleLabel: UILabel!

  fileprivate var webView = WKWebView.init()
  var urlString: String?
  var articleTitle: String?

  class var instance: NewsArticleDetailViewController {
    return Storyboard.main.instantiateVC(NewsArticleDetailViewController.self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    titleLabel.text = articleTitle
    setUpWebView()
  }

  @IBAction func backButtonTapped(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

private extension NewsArticleDetailViewController {

  func setUpWebView() {
    // Setup frame for web view
    showSpinner(with: .lightGray)
    webView.frame = webContainerView.bounds
    webView.isOpaque = false
    webView.backgroundColor = .clear
    webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    webView.navigationDelegate = self
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.allowsLinkPreview = false
    webView.isHidden = true
    // Add webview to container view.
    webContainerView.addSubview(webView)
    webContainerView.autoresizesSubviews = true

    if let url = urlString, let finalUrl = URL(string: url) {
      // Generate the request from the url.
      let request = URLRequest(url: finalUrl)
      // Load the request into the webview.
      debugPrint("web url: \(request.url?.absoluteString ?? "")")
      webView.load(request)
    }
  }
}

// MARK: WKNavigationDelegate
extension NewsArticleDetailViewController: WKNavigationDelegate {

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    debugPrint("Loaded \(webView.debugDescription) with navigation \(navigation.debugDescription)")
    webView.isHidden = false
    removeSpinner()
  }

  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    debugPrint("Webview \(webView.debugDescription) didFail navigation \(navigation.debugDescription) withError \(error.localizedDescription)")
    removeSpinner()
  }

  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    debugPrint("Commited navigation \(navigation.debugDescription) for webview \(webView.debugDescription)")
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    decisionHandler(.allow)
  }
}
