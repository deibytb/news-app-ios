//
//  NewDetailViewController.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import UIKit
import WebKit

class NewDetailViewController: UIViewController {
  
  @IBOutlet weak private var webView: WKWebView!
  
  var viewModel: NewViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.updateUI()
  }
  
  private func updateUI() {
    guard let viewModel = self.viewModel, let request = viewModel.urlRequest else {
      return
    }
    
    self.title = viewModel.new.title ?? viewModel.new.storyTitle ?? "No title"
    self.webView.load(request)
  }
}
