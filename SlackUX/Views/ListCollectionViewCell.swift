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

  override func updateWithModel(model: AnyObject) {
    let item = model as! ListItem
    contentLabel.text = item.text
  }
}
