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

extension NewCodable {
  func date() -> Date? {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter.date(from: self.createdAt)
  }
}
