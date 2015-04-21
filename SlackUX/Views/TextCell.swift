//
//  TextCell.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/20/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell {
  
  struct Const {
    static var ReuseIdentifier = "TextCell"
  }
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  convenience init() {
    self.init(frame: CGRect.zeroRect)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    textLabel.preferredMaxLayoutWidth = 350
    setup()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
  }
  
  func configure(#model: AnyObject, prototype: Bool) {
    let message = model as! Message
    textLabel.text = message.text
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    let str = dateFormatter.stringFromDate(message.date)
    timeLabel.text = str
    usernameLabel.text = message.user.name
    profileImageView.image = message.user.photo
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
}
