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
      let news = try self.context.fetch(request)
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
  
  func updateNew(currentNewId: String, newCodable: NewCodable, completion: ((Bool, CustomError?) -> Void)) {
    self.searchNewBy(id: currentNewId) { (new, error) in
      if let error = error {
        completion(false, error)
      }
      if let new = new {
        new.id = newCodable.objectID
        new.title = newCodable.title
        new.storyTitle = newCodable.storyTitle
        new.author = newCodable.author
        new.createdAt = newCodable.createdAt
        
        do {
          try self.context.save()
          completion(true, nil)
        } catch {
          completion(false, .database(error))
        }
      }
    }
  }
  
  func deleteVehicle(newId: String, completion: ((Bool, CustomError?) -> Void)) {
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
      let vehicle = try self.context.fetch(request).first
      completion(vehicle, nil)
    } catch {
      completion(nil, .database(error))
    }
  }
}
