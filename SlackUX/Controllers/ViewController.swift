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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure collection view
    collectionViewDataSource = CollectionViewDataSource(collectionView: collectionView)
    //collectionView.registerClass(TextCell.self, forCellWithReuseIdentifier: TextCell.Const.ReuseIdentifier)
    let textCellNib = UINib(nibName: "TextCell", bundle: nil)
    collectionView.registerNib(textCellNib, forCellWithReuseIdentifier: TextCell.Const.ReuseIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = collectionViewDataSource
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
