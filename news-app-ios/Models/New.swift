//
//  New.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

struct News: Codable {
  var hits: [New]
}

struct New: Codable {
  var title: String?
  var storyTitle: String
  var author: String
  var createdAt: String
}
