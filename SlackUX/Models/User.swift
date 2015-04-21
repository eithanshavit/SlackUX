//
//  User.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class User: NSObject {
  
  var name: String
  var photo: UIImage
  
  init(name: String, photo: UIImage) {
    self.name = name
    self.photo = photo
  }
   
}
