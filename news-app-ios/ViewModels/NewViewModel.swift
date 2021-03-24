//
//  NewViewModel.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

class NewViewModel {
  
  var new: NewCodable
  var urlRequest: URLRequest?
  
  init(new: NewCodable) {
    self.new = new
    
    let urlString = (new.url ?? new.storyUrl) ?? "https://www.reign.cl/en/"
    if let url = URL(string: urlString) {
      self.urlRequest = URLRequest(url: url)
    }
  }
}
