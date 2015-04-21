//
//  Message.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class Message: NSObject {
  
  var text: String
  var user: User
  var date: NSDate
  
  init(text: String, user: User, date: NSDate) {
    self.text = text
    self.date = date
    self.user = user
  }
   
}
