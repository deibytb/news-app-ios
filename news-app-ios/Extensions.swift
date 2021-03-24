//
//  Extensions.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import Foundation

extension Date {
  func getElapsedInterval() -> String {
    let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
    
    if let year = interval.year, year > 0 {
      return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
    } else if let month = interval.month, month > 0 {
      return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
    } else if let day = interval.day, day > 0 {
      return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
    } else if let hour = interval.hour, hour > 0 {
      return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
    } else if let minute = interval.minute, minute > 0 {
      return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
    } else {
      return "A moment ago"
    }
  }
}
