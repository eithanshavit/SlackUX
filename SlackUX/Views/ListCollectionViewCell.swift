//
//  ListCollectionViewCell.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/22/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class ListCollectionViewCell: DTCollectionViewCell {

  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var snippetLabel: UILabel!

  override func updateWithModel(model: AnyObject) {
    let item = model as! ListItem
    contentLabel.text = item.text
    userLabel.text = item.user
    snippetLabel.text = item.snippet
  }
}

class UserListCollectionViewCell: DTCollectionViewCell {

  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var statusImage: UIImageView!

  override func updateWithModel(model: AnyObject) {
    let item = model as! ListItem
    let online = item.online ?? false
    userLabel.text = item.user
    if online {
      statusImage.image = UIImage(named: "statusOnline")!
    }
    else {
      statusImage.image = UIImage(named: "statusOffline")!
    }
  }
}
