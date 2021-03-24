//
//  NewsViewModel.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

class NewsViewModel {
  
  private(set) var news: [NewCodable] = []
  
  private let db = DBManager()
  
  var loading: ((Bool) -> Void)?
  var didUpdate: (() -> Void)?
  var errorMessage: ((String) -> Void)?
  
  func getNews() {
    self.fetchLocalNews()
    
    if Reachability.isConnectedToNetwork() {
      self.loading?(true)
      APIService().getNews { (data) in
        self.loading?(false)
        if let error = data as? Error {
          self.errorMessage?(error.localizedDescription)
        } else if let newsData = data as? Data {
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let news = try decoder.decode(NewsCodable.self, from: newsData)
            self.saveNews(news.hits)
            self.fetchLocalNews()
          } catch {
            self.errorMessage?(error.localizedDescription)
          }
        }
      }
    }
  }
  
  func fetchLocalNews() {
    self.db.fetchNews { (news, error) in
      if let error = error {
        switch error {
        case .database(let error):
          self.errorMessage?(error.localizedDescription)
        case .validation(let msg):
        self.errorMessage?(msg)
        }
      } else if let news = news {
        self.news = news.map({ NewCodable(fromDB: $0) })
        self.didUpdate?()
      }
    }
  }
  
  func deleteNew(index: Int) {
    let new = self.news[index]
    db.hiddeNew(currentNewId: new.objectID) { (success, error) in
      if success {
        self.news.remove(at: index)
      }
    }
  }
  
  private func saveNews(_ news: [NewCodable]) {
    for new in news {
      db.addNew(newCodable: new) { (_, _) in
      }
    }
  }
}
