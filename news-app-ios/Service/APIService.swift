//
//  APIService.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

class APIService {
  func getNews(completion: @escaping ((Any) -> Void)) {
    guard let url = URL(string: "https://hn.algolia.com/api/v1/search_by_date?query=mobile") else {
      return
    }
    URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
      if let error = error {
        completion(error)
      } else if let data = data {
        completion(data)
      }
    }.resume()
  }
}
