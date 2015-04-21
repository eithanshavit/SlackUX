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
    
    // Some dummy data
    let texts = [
      "in the parking lot this new fallen snow- much of it Reserved",
      "the scent of spring each time you're passing by - midwinter's daydream",
      "A mocking bird sings Moonlight silvers cat whiskers Dozing, she listens",
      "outside the deer park along the chainlink fence deer tracks in the snow",
      "outside the deer park along the chainlink fence deer tracks in the snow outside the deer park along the chainlink fence deer tracks in the snow",
      "A mocking bird sings Moonlight silvers cat whiskers Dozing, she listens",
      "outside the deer park along the chainlink fence deer tracks in the snow",
      "outside the deer park along the chainlink fence deer tracks in the snow outside the deer park along the chainlink fence deer tracks in the snow",
    ]
    
    let users = [
      User(name: "luke", photo: UIImage(named: "luke")!),
      User(name: "vader", photo: UIImage(named: "vader")!),
      User(name: "obi", photo: UIImage(named: "obi")!)
    ]
    
    func getRandomColor() -> UIColor {
      let colors = [
        UIColor(red:0.4, green:0.23, blue:0.72, alpha:1.0),
        UIColor(red:0.01, green:0.53, blue:0.82, alpha:1.0),
        UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0),
        UIColor(red:0.27, green:0.54, blue:1.0, alpha:1.0)
      ]
      return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }

    for (i, text) in enumerate(texts) {
      data.append(Message(text: text, user: users[Int(arc4random_uniform(UInt32(users.count)))], date: NSDate()))
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
