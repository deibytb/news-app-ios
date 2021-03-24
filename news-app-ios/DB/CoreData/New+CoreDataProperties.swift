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
    @NSManaged public var storyTitle: String!
    @NSManaged public var author: String!
    @NSManaged public var createdAt: String!
    @NSManaged public var isHidden: Bool

}

extension New : Identifiable {

}
