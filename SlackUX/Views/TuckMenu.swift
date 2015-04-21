//
//  TuckMenu.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/20/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class TuckMenu: IBReusableView {
  
  @IBOutlet weak var buttonContainer: UIView!
  
  @IBOutlet weak var hashButton: UIButton!
  @IBOutlet weak var chatButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var groupButton: UIButton!
  
  @IBOutlet weak var searchButtonCenterOffset: NSLayoutConstraint!
  @IBOutlet weak var groupButtonCenterOffset: NSLayoutConstraint!
  @IBOutlet weak var chatButtonCenterOffset: NSLayoutConstraint!
  @IBOutlet weak var hashButtonCenterOffset: NSLayoutConstraint!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder, xib: "TuckMenu")
  }
  
  func setRevealedArea(area: CGSize) {
    let revealedPercentage = revealedHeightPercentage(area)
    let buttons: [(UIButton, NSLayoutConstraint, CGFloat)] = [
      (hashButton, hashButtonCenterOffset, 0.7),
      (chatButton, chatButtonCenterOffset, 0.8),
      (groupButton, groupButtonCenterOffset, 0.9),
      (searchButton, searchButtonCenterOffset, 1),
    ]
    for (button, constraint, threshold) in buttons {
      let relativeRevealedPercentage = min(1, revealedPercentage / threshold)
      button.transform = CGAffineTransformMakeScale(relativeRevealedPercentage * 0.5 + 0.5, relativeRevealedPercentage * 0.5 + 0.5)
      button.alpha = revealedPercentage * 0.7 + 0.3
      constraint.constant = 50 * (1 - relativeRevealedPercentage)
    }
  }
  
  func blink() {
  }
  
  
  func revealedHeightPercentage(area: CGSize) -> CGFloat {
    return min(area.height / bounds.height, 1)
  }
  
  func colorForPercentage(percent: CGFloat) -> UIColor {
    let minColorHue: CGFloat = 0.0
    let maxColorHue: CGFloat = 0.18
    let actualHue = (maxColorHue - minColorHue) * percent + minColorHue
    return UIColor(hue: actualHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
  }

}
