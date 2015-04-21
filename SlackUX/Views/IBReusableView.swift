//
//  IBReusableView.swift
//  selek
//
//  Created by  Eithan Shavit on 1/2/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//
//  This is a reusable view. It loads its own XIB file and sets
//  its constrains to fill the size the parent dictated

import UIKit

class IBReusableView: UIView {
  
  var baseView: UIView!
  
  init(coder aDecoder: NSCoder, xib aXib: String) {
    super.init(coder: aDecoder)
    // Load the NIB
    baseView = NSBundle.mainBundle().loadNibNamed(aXib, owner: self, options: nil)[0] as! UIView
    baseView.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(baseView)
    // Set constrains to match size given by parent's constrains
    constrainViewToFill(baseView, padding: 0)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func constrainViewToFill(view: UIView, padding: CGFloat) {
    let delta = padding * 2
    view.setTranslatesAutoresizingMaskIntoConstraints(false)
    addConstraint(NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: delta))
    addConstraint(NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: delta))
    addConstraint(NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
  }
  
  
}
