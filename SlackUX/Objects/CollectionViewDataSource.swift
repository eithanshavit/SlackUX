//
//  CollectionViewDataSource.swift
//  ContentAwareCollectionCell
//
//  Created by  Eithan Shavit on 4/17/15.
//  Copyright (c) 2015  Eithan Shavit. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject {
  
  var data = [AnyObject]()
  var prototypeCells = NSCache()
  var collectionView: UICollectionView!
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    
    let vincent = User(name: "vincent", photo: UIImage(named: "vega")!)
    let jules = User(name: "jules", photo: UIImage(named: "jules")!)
    
    let texts: [(String, User)] = [
      ("And you know what they call a... a... a Quarter Pounder with Cheese in Paris?", vincent),
      ("They don't call it a Quarter Pounder with cheese?", jules),
      ("No man, they got the metric system. They wouldn't know what the fuck a Quarter Pounder is.", vincent),
      ("Then what do they call it?", jules),
      ("They call it a Royale with cheese", vincent),
      ("A Royale with cheese. What do they call a Big Mac?", jules),
      ("Well, a Big Mac's a Big Mac, but they call it le Big-Mac", vincent),
      ("Le Big-Mac. Ha ha ha ha. What do they call a Whopper?", jules),
      ("I dunno, I didn't go into Burger King", vincent),
    ]
    
    for (text, user) in texts {
      data.append(Message(text: text, user: user, date: NSDate()))
    }
  }
  
}

// MARK: - UICollectionViewDataSource

extension CollectionViewDataSource: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = configuredCellForIndexPath(indexPath, prototype: false)
    cell.setNeedsLayout()
    return cell
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
}

// MARK: - Cell configuration

extension CollectionViewDataSource {
  
  func configuredCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell {
    let cell = reusableCellForIndexPath(indexPath, prototype: prototype) as! TextCell
    let model: AnyObject = data[indexPath.row]
    cell.configure(model: model, prototype: prototype)
    return cell
  }
  
  private func cellIdentifierForIndexPath(indexPath: NSIndexPath) -> String {
    let model: AnyObject = data[indexPath.row]
    
    switch model {
    case let model as Message:
      return TextCell.Const.ReuseIdentifier
    default:
      abort()
    }
  }
  
  private func reusableCellForIndexPath(indexPath: NSIndexPath, prototype: Bool) -> UICollectionViewCell {
    // Get reuse identifier
    var cellId = cellIdentifierForIndexPath(indexPath)
    
    // Return protoype if needed
    if prototype {
      return prototypeCellForIdentifier(cellId)
    }
    
    // Return dequeued cell
    return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! UICollectionViewCell
  }
  
  private func prototypeCellForIdentifier(reuseIdentifier: String) -> UICollectionViewCell {
    // Try to fetch prototype from cache
    if let cell = prototypeCells.objectForKey(reuseIdentifier) as? UICollectionViewCell {
      return cell
    }
    
    // Create new cell for reuseIdentifier
    var cell: UICollectionViewCell
    switch reuseIdentifier {
    case TextCell.Const.ReuseIdentifier:
      let textCellNib = UINib(nibName: "TextCell", bundle: nil)
      cell = textCellNib.instantiateWithOwner(nil, options: nil).first as! TextCell
    default:
      abort()
    }
    
    // Cache it
    prototypeCells.setObject(cell, forKey: reuseIdentifier)
    
    return cell
  }
  
  
}
