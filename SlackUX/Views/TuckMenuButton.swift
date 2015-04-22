//
//  TuckMenuButton.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/21/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class TuckMenuButton: UIButton {
  
  var touchIndicator = TouchIndicatorCircle()
  
  @IBInspectable var indicatorColor: UIColor! {
    didSet {
      touchIndicator.fillColor = indicatorColor
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    addSubview(touchIndicator)
    touchIndicator.backgroundColor = UIColor.clearColor()
    touchIndicator.alpha = 0
    addTarget(self, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside)
    clipsToBounds = false

  }
  
  override var bounds: CGRect {
    didSet {
      touchIndicator.frame = bounds
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    sendSubviewToBack(touchIndicator)
  }

  func buttonAction(sender: UIButton!) {
    
    self.touchIndicator.alpha = 1
    self.touchIndicator.transform = CGAffineTransformIdentity
    UIView.animateWithDuration(
      0.5,
      delay: 0,
      options: UIViewAnimationOptions.CurveEaseOut,
      animations: {
        () -> Void in
        self.touchIndicator.transform = CGAffineTransformMakeScale(2, 2)
        self.touchIndicator.alpha = 0
      },
      completion: {
        (finished) -> Void in
        self.touchIndicator.transform = CGAffineTransformMakeScale(0.1, 0.1)
      }
    )

  }
  

}

class TouchIndicatorCircle: UIView {
  
  var fillColor = UIColor.blackColor()
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    let path = UIBezierPath(ovalInRect: rect)
    fillColor.setFill()
    path.fill()
  }
}
