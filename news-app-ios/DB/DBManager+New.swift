//
//  DBManager+New.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

extension DBManager {
  
  func fetchNews(completion: (([New]?, CustomError?) -> Void)) {
    let request = New.createFetchRequest()
    
    request.predicate = NSPredicate(format: "isHidden == %@", NSNumber(value: false))
    
    do {
      var news = try self.context.fetch(request)
      
      news.sort { (new1, new2) -> Bool in
        if let date1 = new1.date(), let date2 = new2.date() {
          return date1.compare(date2) == .orderedDescending
        } else {
          return false
        }
      }
      
      completion(news, nil)
    } catch {
      completion(nil, .database(error))
    }
  }
  
  func addNew(newCodable: NewCodable, completion: ((Bool, CustomError?) -> Void)) {
    self.searchNewBy(id: newCodable.objectID) { (new, _) in
      if let _ = new {
        completion(false, .validation("The new is already created"))
      } else {
        let newNew = New(context: self.context)
        newNew.id = newCodable.objectID
        newNew.title = newCodable.title
        newNew.storyTitle = newCodable.storyTitle
        newNew.author = newCodable.author
        newNew.createdAt = newCodable.createdAt
        newNew.isHidden = false
        
        do {
          try self.context.save()
          completion(true, nil)
        } catch {
          completion(false, .database(error))
        }
      }
    }
  }
  
  func hiddeNew(currentNewId: String, completion: ((Bool, CustomError?) -> Void)) {
    self.searchNewBy(id: currentNewId) { (new, error) in
      if let error = error {
        completion(false, error)
      }
      if let new = new {
        new.isHidden = true
        
        do {
          try self.context.save()
          completion(true, nil)
        } catch {
          completion(false, .database(error))
        }
      }
    }
  }
  
  func deleteNew(newId: String, completion: ((Bool, CustomError?) -> Void)) {
    self.searchNewBy(id: newId) { (new, error) in
      if let error = error {
        completion(false, error)
      }
      if let new = new {
        self.context.delete(new)
        
        do {
          try self.context.save()
          completion(true, nil)
        } catch {
          completion(false, .database(error))
        }
      }
    }
  }
  
  func searchNewBy(id: String, completion: ((New?, CustomError?) -> Void)) {
    let request = New.createFetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id)
    
    do {
      let new = try self.context.fetch(request).first
      completion(new, nil)
    } catch {
      completion(nil, .database(error))
    }
  }
}
