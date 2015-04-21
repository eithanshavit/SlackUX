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
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder, xib: "TuckMenu")
  }
  
  func setRevealedArea(area: CGSize) {
    baseView.backgroundColor = colorForPercentage(revealedHeightPercentage(area))
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
