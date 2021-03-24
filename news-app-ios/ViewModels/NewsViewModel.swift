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
  
  var didUpdate: (() -> Void)?
  var errorMessage: ((String) -> Void)?
  
  func getNews() {
    if Reachability.isConnectedToNetwork() {
      APIService().getNews { (data) in
        if let error = data as? Error {
          self.errorMessage?(error.localizedDescription)
        } else if let newsData = data as? Data {
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let news = try decoder.decode(NewsCodable.self, from: newsData)
            self.news = news.hits
            self.didUpdate?()
            self.saveNews(news.hits)
          } catch {
            print(error.localizedDescription)
            self.errorMessage?(error.localizedDescription)
          }
        }
      }
    } else {
      self.db.fetchNews { (news, error) in
        if let error = error {
          switch error {
          case .database(let error):
            self.errorMessage?(error.localizedDescription)
          case .validation(let msg):
          self.errorMessage?(msg)
          }
        } else if let news = news {
          print(news)
          self.news = news.map({ NewCodable(fromDB: $0) })
          self.didUpdate?()
        }
      }
    }
  }
  
  private func saveNews(_ news: [NewCodable]) {
    for new in news {
      db.addNew(newCodable: new) { (success, error) in
        if success {
          print("SAVED: ", new.objectID)
        } else {
          if let error = error {
            switch error {
            case .database(let error):
              print(new.objectID, error.localizedDescription)
            case .validation(let msg):
              print(new.objectID, msg)
            }
          }
        }
      }
    }
  }
}
