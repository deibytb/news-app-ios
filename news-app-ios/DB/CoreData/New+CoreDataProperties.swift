//
//  New+CoreDataProperties.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//
//

import Foundation
import CoreData


extension New {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<New> {
        return NSFetchRequest<New>(entityName: "New")
    }

    @NSManaged public var id: String!
    @NSManaged public var title: String?
    @NSManaged public var storyTitle: String?
    @NSManaged public var author: String!
    @NSManaged public var createdAt: String!
    @NSManaged public var isHidden: Bool
    @NSManaged public var url: String?
    @NSManaged public var storyUrl: String?

}

extension New : Identifiable {

}

extension New {
  func date() -> Date? {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    return formatter.date(from: self.createdAt)
  }
}
