//
//  ListViewController.swift
//  SlackUX
//
//  Created by  Eithan Shavit on 4/21/15.
//  Copyright (c) 2015 Eithan Shavit. All rights reserved.
//

import UIKit

class ListViewController: DTCollectionViewController {
  
  @IBOutlet weak var headerImageView: UIImageView! {
    didSet {
      headerImageView.image = headerImage
    }
  }
  var headerImage: UIImage!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    registerCellClass(ListCollectionViewCell.self, forModelClass:ListItem.self)
    
    let data = [
      ListItem(text: "sfdd"),
      ListItem(text: "lkjlkj")
    ]
    self.memoryStorage().addItems(data)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func backButtonTap(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 50)
  }
}

class ListItem: NSObject {
  
  var text: String
  
  init(text: String) {
    self.text = text
  }
  
}