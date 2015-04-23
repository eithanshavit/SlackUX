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
  var type = "channels"
  var data = [ListItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if type == "channels" {
    
      registerCellClass(ListCollectionViewCell.self, forModelClass:ListItem.self)
      
      if data.isEmpty {
        let items: [(text: String, user: String, snippet: String)] = [
          ("design", "@james", "red is a much nicer color"),
          ("finance", "@john", "we can't afford the CEO"),
          ("development", "@jake", "I can't get this to work"),
          ("bugs", "@fred", "there are just too many"),
          ("office", "@dana", "party next week!!!!"),
          ("marketing", "@bill", "not sure we can sell this"),
          ("UX", "@dave", "it's super easy to use"),
          ("random", "@maya", "the number 42"),
          ("general", "@jane", "What are we doing here?"),
          ("HR", "@kate", "you're fired"),
          ("business", "@paul", "trust me on this one"),
        ]
        for (text, user, snippet) in items {
          data.append(ListItem(text: "#" + text, user: user, snippet: snippet))
        }
        self.memoryStorage().addItems(data)
      }
    }
    
    if type == "chats" {
      registerCellClass(UserListCollectionViewCell.self, forModelClass:ListItem.self)
      
      if data.isEmpty {
        let items: [(user: String, online: Bool)] = [
          ("jane", true),
          ("david", false),
          ("vincent", true),
          ("mark", true),
          ("tom", false),
          ("peter", true),
          ("anna", true),
          ("vicky", true),
          ("mike", false),
          ("sidney", true),
          ("bob", false),
          ("chandra", true),
          
        ]
        for (user, online) in items {
          data.append(ListItem(user: "@" + user, online: online))
        }
        self.memoryStorage().addItems(data)
      }
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func backButtonTap(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

extension ListViewController: UICollectionViewDelegate {
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let main = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
    main.modalTransitionStyle = .CrossDissolve
    main.headerImage = UIImage(named: "newHeaderChat")!
    presentViewController(main, animated: true, completion: nil)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 55)
  }
}

class ListItem: NSObject {
  
  var text: String!
  var user: String!
  var snippet: String!
  var online: Bool!
  
  init(text: String, user: String, snippet: String) {
    self.text = text
    self.user = user
    self.snippet = snippet
  }
  
  init(user: String, online: Bool) {
    self.user = user
    self.online = online
  }
  
}