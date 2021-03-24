//
//  New.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

struct NewsCodable: Codable {
  var hits: [NewCodable]
}

struct NewCodable: Codable {
  var objectID: String
  var title: String?
  var storyTitle: String?
  var author: String
  var createdAt: String
}

extension NewCodable {
  init(fromDB newDB: New) {
    self.objectID = newDB.id
    self.title = newDB.title
    self.storyTitle = newDB.storyTitle
    self.author = newDB.author
    self.createdAt = newDB.createdAt
  }
}
