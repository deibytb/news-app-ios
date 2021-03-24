//
//  DBManager.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation
import CoreData

class DBManager {
  
  enum CustomError {
    case database(_ error: Error)
    case validation(_ msg: String)
  }
  
  var context: NSManagedObjectContext
  
  init() {
    let dbManager = CoreDataService.shared
    self.context = dbManager.dbContext
  }
}
