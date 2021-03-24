//
//  NewsViewModel.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

class NewsViewModel {
  
  private(set) var news: [New] = []
  
  var didUpdate: (() -> Void)?
  var errorMessage: ((String) -> Void)?
  
  func getNews() {
    APIService().getNews { (data) in
      if let error = data as? Error {
        self.errorMessage?(error.localizedDescription)
      } else if let newsData = data as? Data {
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let news = try decoder.decode(News.self, from: newsData)
          self.news = news.hits
          self.didUpdate?()
        } catch {
          self.errorMessage?(error.localizedDescription)
        }
      }
    }
  }
  
}
