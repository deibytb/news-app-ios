//
//  NewTableViewCell.swift
//  news-app-ios
//
//  Created by Deiby Toralva on 3/24/21.
//

import UIKit

class NewTableViewCell: UITableViewCell {
  
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var autorTimestampLabel: UILabel!
  
  var new: NewCodable? {
    didSet {
      self.updateUI()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  private func updateUI() {
    guard let new = self.new else {
      return
    }
    
    self.titleLabel.text = new.title ?? new.storyTitle ?? "No title"
    self.autorTimestampLabel.text = "\(new.author) - \(new.createdAt)"
  }
}
