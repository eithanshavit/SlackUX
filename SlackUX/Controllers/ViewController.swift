//
//  ViewController.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/20/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var collectionViewDataSource: CollectionViewDataSource!
  private var cellSizeCache = NSCache()
  private var tuckMenuLocked = false
  private var tuckMenuBlinked = false
  
  var tuckMenu = TuckMenu()
  var collectionBackgroundView = UIView()
  
  private var menuHeight: CGFloat {
    return tuckMenu.bounds.height
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure collection view
    collectionViewDataSource = CollectionViewDataSource(collectionView: collectionView)
    let textCellNib = UINib(nibName: "TextCell", bundle: nil)
    collectionView.registerNib(textCellNib, forCellWithReuseIdentifier: TextCell.Const.ReuseIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = collectionViewDataSource
    collectionView.panGestureRecognizer.addTarget(self, action: "handlePan:")
    
    collectionBackgroundView.backgroundColor = UIColor.whiteColor()
    collectionView.backgroundView = collectionBackgroundView
    collectionBackgroundView.addSubview(tuckMenu)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tuckMenu.frame = CGRect(x: 0, y: collectionBackgroundView.bounds.height - 70 , width: collectionBackgroundView.bounds.width, height: 70)
  }
  
}

// MARK: - UICollectionViewFlowLayout Delegate

extension ViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    // If fitted size was computed in the past for this cell, return it from cache
    if let size = cellSizeCache.objectForKey(indexPath) as? NSValue {
      return size.CGSizeValue()
    }
    
    let cell = collectionViewDataSource.configuredCellForIndexPath(indexPath, prototype: true) as! TextCell
    let width = collectionView.bounds.width
    let size = cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    
    // Cache it
    cellSizeCache.setObject(NSValue(CGSize: size), forKey: indexPath)
    
    return CGSize(width: width, height: size.height)
  }
  
}

// MARK: - UIScrollViewDelegate and gestures

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    scrollViewdidScrollToOffsetFromBottom(scrollViewBottomOffset)
  }
  
  func scrollViewdidScrollToOffsetFromBottom(offset: CGFloat) {
    tuckMenuLocked = offset >= menuHeight
    if tuckMenuLocked {
      if !tuckMenuBlinked {
        tuckMenu.blink()
        tuckMenuBlinked = true
      }
    }
    else {
      tuckMenuBlinked = false
    }
    tuckMenu.setRevealedArea(CGSize(width: tuckMenu.bounds.width, height: offset))
  }
  
  private var scrollViewBottomOffset: CGFloat {
    let bottomOfContent = collectionView.contentSize.height - collectionView.contentOffset.y
    return CGRectGetHeight(collectionView.frame) - bottomOfContent
  }
  
  @objc
  private func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Ended {
      //let velocity = recognizer.velocityInView(collectionView).y
      let insetButtom = tuckMenuLocked ? menuHeight : 0
      UIView.animateWithDuration(
        0.2,
        delay: 0,
        options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseInOut,
        animations: {
          finished in
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: insetButtom, right: 0)
        },
        completion: nil
      )
    }
  }
  
}
