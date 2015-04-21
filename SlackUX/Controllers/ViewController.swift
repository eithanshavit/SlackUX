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
  @IBOutlet weak var tuckMenu: TuckMenu!
  
  private var collectionViewDataSource: CollectionViewDataSource!
  private var cellSizeCache = NSCache()
  private var tuckMenuLocked = false
  
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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
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
    tuckMenuLocked = offset > menuHeight
    tuckMenu.setRevealedArea(CGSize(width: tuckMenu.bounds.width, height: offset))
  }
  
  private var scrollViewBottomOffset: CGFloat {
    let bottomOfContent = collectionView.contentSize.height - collectionView.contentOffset.y
    return CGRectGetHeight(collectionView.frame) - bottomOfContent
  }
  
  @objc
  private func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Ended {
      let triggeringValue = menuHeight
      let velocity = recognizer.velocityInView(collectionView).y
      
      if scrollViewBottomOffset > triggeringValue {
        UIView.animateWithDuration(
          0.2,
          delay: 0,
          options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseInOut,
          animations: {
            finished in
              self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.menuHeight, right: 0)
              //self.collectionView.contentOffset.y = -self.scrollView.contentInset.top
          },
          completion: nil
      )}
    }
  }
  
}
